//
//  ShareInteractor.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/23/17.
//  Copyright (c) 2017 Ahmed Henawey. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ShareInteractorInput
{
    func shareOnFacebook(request: Share.Request)
    func shareOnTwitter(from viewController: UIViewController,request: Share.Request)
    var image: UIImage {get set}
}

protocol ShareInteractorOutput
{
    func presentShareSucceed(shareResponse:Share.Response)
    func presentShareError(error: Share.Error)
}

class ShareInteractor: ShareInteractorInput
{
    var output: ShareInteractorOutput!
    var worker: ShareWorker!
    
    // MARK: - Business logic
    var _image: UIImage!
    
    var image: UIImage{
        set{
            _image = newValue
        }
        get{
            return _image
        }
    }
    func shareOnTwitter(from viewController: UIViewController,request: Share.Request){
        
        worker = ShareWorker()
        
        worker.twitterShare(from: viewController, request:request) { (result) in
            switch result{
            case let .success(shareResponse):
                self.output.presentShareSucceed(shareResponse: shareResponse)
                break
            case let .failure(error):
                self.output.presentShareError(error: error)
                break
            }
        }
    }
    
    func shareOnFacebook(request: Share.Request){
        // Create Home Worker to do the sharing work
        
        worker = ShareWorker()
        
        worker.facebookShare(request: request) { (result) in
            switch result{
            case let .success(shareResponse):
                self.output.presentShareSucceed(shareResponse: shareResponse)
                break
            case let .failure(error):
                self.output.presentShareError(error: error)
                break
            }
        }
    }
}