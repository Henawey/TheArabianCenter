//
//  ShareWorker.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/23/17.
//  Copyright (c) 2017 Ahmed Henawey. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import FacebookShare
import Social

import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

import TwitterKit

import Result

import ObjectMapper

class ShareWorker
{
    // MARK: - Business Logic
    
    func save(request:Sync.Save.Request,compilation:@escaping (Result<String,Sync.Error>)->()) {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil{
                compilation(.failure(Sync.Error.configurationMissing))
                return
            }
            
            guard let firebaseKey = Configuration.sharedInstance.firebaseDatabaseOfferKey() else {
                compilation(.failure(Sync.Error.configurationMissing))
                return
            }
            //submit item
            let ref: FIRDatabaseReference = FIRDatabase.database().reference()
            let child = ref.child(firebaseKey).childByAutoId()
            child.setValue(request.toJSON(), withCompletionBlock: { (error, reference) in
                guard let error = error else{
                    compilation(.success(reference.key))
                    return
                }
                compilation(.failure(Sync.Error.failure(error: error)))
            })
        })
    }
    
    func retrieve(request: Sync.Retrieve.Request,compilation:@escaping (Result<Sync.Response,Sync.Error>)->()){
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil{
                compilation(.failure(Sync.Error.configurationMissing))
                return
            }
            guard let firebaseKey = Configuration.sharedInstance.firebaseDatabaseOfferKey() else {
                compilation(.failure(Sync.Error.configurationMissing))
                return
            }
            // retrieve item
            let ref: FIRDatabaseReference = FIRDatabase.database().reference()
            let child = ref.child(firebaseKey).child(request.id)
            child.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard var value = snapshot.value as? [String : Any] else{
                    compilation(.failure(Sync.Error.invalidData))
                    return
                }
                
                value["id"] = child.key
                
                guard let response = Mapper<Sync.Response>().map(JSON:value) else{
                    compilation(.failure(Sync.Error.invalidData))
                    return

                }
                
                compilation(.success(response))
                
            }) { (error) in
                compilation(.failure(Sync.Error.failure(error: error)))
            }
        })
    }
    
    func twitterShare(from viewController:UIViewController,request:Share.Request,
                      compilation:@escaping (Result<Share.Response,Share.Error>)->()) {
        
        guard var urlAsString = Configuration.sharedInstance.twitterAppCardConfigurationLink() else{
            compilation(.failure(Share.Error.configurationMissing))
            return
        }
        
        guard let image = request.image else{
            compilation(.failure(Share.Error.invalidData))
            return
        }
        
        urlAsString.append("&offerId=\(request.id)")
        
        guard let url = URL(string: urlAsString) else {
            compilation(.failure(Share.Error.unknownError))
            return
        }
        
        let composer = TWTRComposer()
        composer.setURL(url)
        composer.setImage(image)
        composer.show(from: viewController) { (result) in
            switch result{
            case .done:
                let response = Share.Response(id: request.id, title: request.title, description: request.description,image:image)
                compilation(.success(response))
            case .cancelled:
                compilation(.failure(Share.Error.shareCancelled))
            }
        }
    }
    
    func facebookShare(request:Share.Request,
                       compilation:@escaping (Result<Share.Response,Share.Error>)->()){
        
        guard var urlAsString = Configuration.sharedInstance.facebookApplink() else{
            compilation(.failure(Share.Error.configurationMissing))
            return
        }
        
        guard let imageURL = request.imageURL else{
            compilation(.failure(Share.Error.invalidData))
            return
        }
        
        urlAsString.append("&offerId=\(request.id)")
        
        guard let url = URL(string: urlAsString) else {
            compilation(.failure(Share.Error.unknownError))
            return
        }
        
        let shareContent = LinkShareContent(url: url, title: request.title, description: request.description, quote: nil, imageURL: imageURL)
        
        let shareDialog:ShareDialog = ShareDialog(content: shareContent)
        
        //workaround because (canShow:) is not supported yet in FB Swift SDK also there is a bug in ".feed" type and for this I can't use ".automatic" Option
        if UIApplication.shared.canOpenURL(URL(string: "fbauth2://")!){
            shareDialog.mode = .native
        }else if SLComposeViewController.isAvailable(forServiceType: "com.apple.share.Facebook.post") {
            shareDialog.mode = .shareSheet
        } else{
            shareDialog.mode = .web
        }
        
        shareDialog.completion = { result in
            switch result {
            case .success(_):
                let response = Share.Response(id:request.id,title: request.title, description: request.description,imageURL:imageURL)
                compilation(.success(response))
            case .cancelled:
                compilation(.failure(Share.Error.shareCancelled))
            case let .failed(error):
                compilation(.failure(Share.Error.failure(error: error)))
            }
        }
        do{
            try shareDialog.show()
        }catch{
            compilation(.failure(Share.Error.failure(error: error)))
        }
    }
    
    func uploadImage(request:Image.Upload.Request ,progress:@escaping (_ percent:Double)->() = {_ in },compilation:@escaping (Result<Image.Upload.Response,Image.Upload.Error>)->()) {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if error != nil{
                compilation(.failure(Image.Upload.Error.configurationMissing))
                return
            }
            
            // Get a reference to the storage service using the default Firebase App
            let storage = FIRStorage.storage()
            
            guard let firebaseStorageLink = Configuration.sharedInstance.firebaseStorage(),let firebaseKey = Configuration.sharedInstance.firebaseDatabaseOfferKey() else {
                compilation(.failure(Image.Upload.Error.configurationMissing))
                return
            }
            // Create a root reference
            let storageRef = storage.reference(forURL: firebaseStorageLink)
            
            // Create a reference to the file you want to upload
            let riversRef = storageRef.child(firebaseKey).child("\(Date().timeIntervalSince1970)")
            
            // Create file metadata including the content type
            let metadata = FIRStorageMetadata()
            metadata.contentType = request.data.contentType()
            
            // Upload the file
            let uploadTask = riversRef.put(request.data, metadata: metadata)
            
            // Listen for state changes, errors, and completion of the upload.
            uploadTask.observe(.resume) { snapshot in
                // Upload resumed, also fires when the upload starts
            }
            
            uploadTask.observe(.pause) { snapshot in
                // Upload paused
            }
            
            uploadTask.observe(.progress) { snapshot in
                // Upload reported progress
                let percentComplete = Double(snapshot.progress!.completedUnitCount)
                    / Double(snapshot.progress!.totalUnitCount)
                progress(percentComplete)
            }
            
            uploadTask.observe(.success) { snapshot in
                // Upload completed successfully
                
                // Metadata contains file metadata such as size, content-type, and download URL.
                guard let downloadURL : URL = snapshot.metadata?.downloadURL() else{
                    compilation(.failure(Image.Upload.Error.failDuringUpload))
                    return
                }
                compilation(.success(Image.Upload.Response(url:downloadURL.absoluteString)))
                
            }
            
            uploadTask.observe(.failure) { snapshot in
                if (snapshot.error as? NSError) != nil {
                    compilation(.failure(Image.Upload.Error.failDuringUpload))
                }
            }
        })
    }
    
    func submitLocation(reqeust:Location.Request){
        
    }
}
