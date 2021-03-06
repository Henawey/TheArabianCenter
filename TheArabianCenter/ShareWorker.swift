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

import TwitterKit

import Result

class ShareWorker
{
    // MARK: - Business Logic
    
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
        composer.setText("\(request.title) - \(request.description)")
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
        
        urlAsString.append("?offerId=\(request.id)")
        
        guard let url = URL(string: urlAsString) else {
            compilation(.failure(Share.Error.unknownError))
            return
        }
        
        
        let shareContent = LinkShareContent(url: url, title: request.title, description: request.description, quote: nil, imageURL: imageURL)
        
        let shareDialog:ShareDialog = ShareDialog(content: shareContent)
        
        shareDialog.completion = { result in
            switch result {
            case let .success(result):
                guard (result.postId != nil) else {
                    compilation(.failure(Share.Error.shareCancelled))
                    return
                }
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
}
