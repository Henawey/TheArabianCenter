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
    func presentImageProccessed(response: Home.Offer.Image.Response)
    func presentImageError(error: Home.Offer.Image.Error)
    
    func presentLocationError(error: Location.Error)
    
    func presentCameraAvaliable()
    func presentCameraNotAvaliable()
}

protocol HomePresenterOutput: class
{
    func displayLocationPermissionHelper(message: String)
    func displayCameraImage(viewModel:Home.Offer.Image.ViewModel)
    
    func displayMessage(title: String, message:String,actionTitle:String)
    
    func displayCameraAvaliable()
}

class HomePresenter: HomePresenterInput
{
    weak var output: HomePresenterOutput!
    
    // MARK: - Presentation logic
    
    
    /// Extract Image from successful response for presentation on UI
    ///
    /// - Parameter response: Raw Response From UIImagePickerController
    func presentImageProccessed(response: Home.Offer.Image.Response) {
        guard let image = response.result[UIImagePickerControllerOriginalImage] as? UIImage else{
            self.presentImageError(error: Home.Offer.Image.Error.noImageFound)
            return
        }
        
        let viewModel = Home.Offer.Image.ViewModel(image: image)
        
        self.output.displayCameraImage(viewModel: viewModel)
    }
    
    
    /// Prepare and localized the error for presenting and pass the error back to the View Controller
    ///
    /// - Parameter error: Error happen during get Image
    func presentImageError(error: Home.Offer.Image.Error) {
        switch error {
        case .noImageFound:
            self.output.displayMessage(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("No Image", comment: ""), actionTitle: NSLocalizedString("OK", comment: ""))
        default:
            self.output.displayMessage(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Unknown Error", comment: ""), actionTitle: NSLocalizedString("OK", comment: ""))
        }
    }
    
    
    /// Prepare and localize the error happen during location retrieving and pass the error back to the View Controller
    ///
    /// - Parameter error: error
    func presentLocationError(error: Location.Error){
        switch error {
        case .locationAuthorizaionRequired:
            self.output.displayLocationPermissionHelper(message: NSLocalizedString("We need your permission to get your location", comment: ""))
        case .locationRequired:
            self.output.displayMessage(title: NSLocalizedString("Unable To locate you", comment: ""), message: NSLocalizedString("Please Try to go somewhere else so we can locate you", comment: ""), actionTitle: NSLocalizedString("OK", comment: ""))
        default:
            self.output.displayMessage(title: NSLocalizedString("Error", comment: ""), message:error.localizedDescription, actionTitle: NSLocalizedString("OK", comment: ""))
        }
        
    }
    
    
    /// Present Camera Avaliable
    func presentCameraAvaliable(){
        self.output.displayCameraAvaliable()
    }
    
    /// Prepare and locaize that message there is no camera avaliable and pass the result back to the View Controller
    func presentCameraNotAvaliable(){
        self.output.displayMessage(title: NSLocalizedString("Camera Not Avaliable", comment: ""), message: NSLocalizedString("You can claim offers without camera", comment: ""), actionTitle: NSLocalizedString("OK", comment: ""))
    }
}

