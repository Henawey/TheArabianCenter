//
//  LocationModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation

struct Location {
    struct Request {
        
    }
    
    struct Response {
        
    }
    enum Error:Swift.Error {
        case locationRequired
        case locationAuthorizaionRequired
    }
}
