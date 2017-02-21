//
//  HomePresenter.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/18/17.
//  Copyright (c) 2017 Ahmed Henawey. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol HomePresenterInput
{
    func presentShareSucceed(shareResponse:Home.Offer.Share.Response)
    func presentShareError(error: Home.Offer.Share.Error)
    
}

protocol HomePresenterOutput: class
{
    func displayShareSuccess(viewModel: Home.Offer.ViewModel)
    func displayMessage(title: String, message:String,actionTitle:String)
}

class HomePresenter: HomePresenterInput
{
    weak var output: HomePresenterOutput!
    
    // MARK: - Presentation logic
    
    func presentShareSucceed(shareResponse :Home.Offer.Share.Response){
        // Format the response from the Interactor and pass the result back to the View Controller
        
    }
    func presentShareError(error: Home.Offer.Share.Error){
        // Format the response from the Interactor and pass the result back to the View Controller
        self.output.displayMessage(title: NSLocalizedString("Canceled", comment: ""), message: NSLocalizedString("Can't claim until share the offer on social media", comment: ""), actionTitle: NSLocalizedString("Ok", comment: ""))
    }
    
    
}
