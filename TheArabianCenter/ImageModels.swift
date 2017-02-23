//
//  ImageModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation
import CoreLocation

struct Image {
    struct Upload {
        struct Request {
            var name: String
            var data: Data
        }
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    struct Download {
        
        struct Request {
            var name: String
            var data: Data
        }
        
        struct Response {
            var name: String
            var data: Data
        }
        
        struct ViewModel {
            var name: String
            var data: Data
        }
    }
}
