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

protocol ShareViewControllerInput
{
    func displayShareSuccess(viewModel: Share.ViewModel)
    func displayMessage(title: String, message:String,actionTitle:String)
}

protocol ShareViewControllerOutput
{
    func shareOnFacebook(request: Share.Request)
    func shareOnTwitter(from viewController: UIViewController,request: Share.Request)
    var image: UIImage {get set}
}

class ShareViewController: UIViewController, ShareViewControllerInput
{
    var output: ShareViewControllerOutput!
    var router: ShareRouter!
    
    @IBOutlet var imageView:UIImageView?
    
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
        self.imageView?.image = self.output.image
    }
    
    // MARK: - Event handling
    
    @IBAction func facebookShare(){
        self.output.shareOnFacebook(request: Share.Request(id:"\(Date().timeIntervalSince1970)",title: "Test Title", description: "Test Description",image: self.output.image))
    }
    
    @IBAction func twitterShare(){
        self.output.shareOnTwitter(from: self, request: Share.Request(id:"\(Date().timeIntervalSince1970)",title: "Test Title", description: "Test Description",image: self.output.image))
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