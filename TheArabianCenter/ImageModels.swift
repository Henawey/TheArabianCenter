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
            var data: Data
        }
        struct Response {
            var url: String
        }
        
        struct ViewModel {
            
        }
        
        enum Error:Swift.Error {
            case configurationMissing
            case failDuringUpload
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
