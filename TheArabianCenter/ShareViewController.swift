//
//  ShareViewController.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/23/17.
//  Copyright (c) 2017 Ahmed Henawey. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import CoreLocation

protocol ShareViewControllerInput
{
    func displayShareSuccess(viewModel: Share.ViewModel)
    func displayMessage(title: String, message:String,actionTitle:String)
    func displaySyncSucceed(syncResponse:Sync.ViewModel)
}

protocol ShareViewControllerOutput
{
    func shareOnFacebook(request: Share.UI.Request)
    func shareOnTwitter(from viewController: UIViewController,request: Share.UI.Request)
    
    func save(request: Sync.Save.Request)
    func retrieve(request: Sync.Retrieve.Request)
    
    var image: UIImage? {get set}
    var userLocation: CLLocation? {get set}
}

class ShareViewController: UIViewController, ShareViewControllerInput
{
    var output: ShareViewControllerOutput!
    var router: ShareRouter!
    
    let disposeBag = DisposeBag()
    @IBOutlet var imageView:UIImageView?
    
    var offer:Variable<Sync.ViewModel?> = Variable(nil)
    
    var shareClousre : (_ offer:Sync.ViewModel) -> () = { offer in }
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        ShareConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if self.output.image != nil {
            self.output.save(request: Sync.Save.Request(title: "Test Title", description: "Test Description", image: self.output.image!,location:self.output.userLocation))
        }
        
        offer.asObservable().subscribe(onNext: { (viewModel) in
            guard let imageLocation = viewModel?.imageLocation,
                let url = URL(string:imageLocation) else{
                    return
            }
            self.imageView?.sd_setImage(with: url, completed: { (image, error, cachType, url) in
                guard let image = image else{
                    return
                }
                
                self.output.image = image
            })
            
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: - Event handling
    
    func displaySyncSucceed(syncResponse:Sync.ViewModel){
        
        self.offer.value = syncResponse
        
        shareClousre(syncResponse)
        
    }
    
    func loadOffer(offerId: String){
        self.output.retrieve(request: Sync.Retrieve.Request(id: offerId))
    }
    
    @IBAction func facebookShare(){
        
        shareClousre = { offer in
            let imageURL = URL(string: offer.imageLocation)
            
            self.output.shareOnFacebook(request: Share.UI.Request(id:offer.id,title:offer.title,description:offer.description,imageURL:imageURL))
        }
        
        if(offer.value != nil){
            shareClousre(offer.value!)
        }
        
        
    }
    
    @IBAction func twitterShare(){

        shareClousre = {  offer in
            self.output.shareOnTwitter(from: self, request: Share.UI.Request(id:offer.id,title:offer.title,description:offer.description,image: self.output.image))
        }
        
        if(offer.value != nil){
            shareClousre(offer.value!)
        }
    }
    
    // MARK: - Display logic
    func displayShareSuccess(viewModel: Share.ViewModel) {
        // NOTE: Display the result from the Presenter
        // Submit location
        print("claimed")
    }
    
    func displayMessage(title: String, message:String,actionTitle:String) {
        // NOTE: Display the result from the Presenter
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
