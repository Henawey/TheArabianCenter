//
//  LocationModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation


/// Location Model for handling error in request, Request and resposne Empty for any further usage
struct Location {
    struct Request {
        
    }
    
    struct Response {
        
    }
    enum Error:Swift.Error {
        case locationRequired
        case locationAuthorizaionRequired
        
        case failure(error:Swift.Error)
        
        var localizedDescription: String{
            switch self {
            case .locationRequired:
                return NSLocalizedString("locationRequired", comment: "")
                
            case .locationAuthorizaionRequired:
                return NSLocalizedString("locationAuthorizaionRequired", comment: "")
            case let .failure(error):
                return error.localizedDescription
            }
        }
    }
}
