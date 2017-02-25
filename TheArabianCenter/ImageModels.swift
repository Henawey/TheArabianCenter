//
//  ImageModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


/// Image Models user for upload image to firebase
struct Image {
    struct Upload {
        struct Request {
            var data: Data
        }
        struct Response {
            var url: URL
        }
        
        struct ViewModel {
            
        }
        
        enum Error:Swift.Error {
            case configurationMissing
            case failDuringUpload
            
            case failure(error:Swift.Error)
            
            var localizedDescription: String{
                switch self {
                case .failDuringUpload:
                    return NSLocalizedString("failDuringUpload", comment: "")
                    
                case .configurationMissing:
                    return NSLocalizedString("configurationMissing", comment: "")
                case let .failure(error):
                    return error.localizedDescription
                }
            }
        }
    }
    
    struct Download {
        struct Request {
            var url: URL
        }
        struct Response {
            var image: UIImage
        }
        
        struct ViewModel {
            var image: UIImage
        }
        
        enum Error : Swift.Error {
            case configurationMissing
            case failDuringDownload
            
            case failure(error:Swift.Error)
            
            var localizedDescription: String{
                switch self {
                case .failDuringDownload:
                    return NSLocalizedString("failDuringDownload", comment: "")
                    
                case .configurationMissing:
                    return NSLocalizedString("configurationMissing", comment: "")
                case let .failure(error):
                    return error.localizedDescription
                }
            }
        }
    }
}
