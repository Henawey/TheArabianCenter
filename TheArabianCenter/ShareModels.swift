//
//  ShareModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import CoreLocation


struct UI {
    struct Share {
        struct Request
        {
            var title:String?
            var description:String?
            var image:UIImage?
            
            init(title:String? = nil,
                 description:String? = nil,
                 image:UIImage? = nil) {
                
                self.title = title
                self.description = description
                self.image = image
            }
        }
    }
    
    struct Image {
        struct Download {
            struct Request {
                var imageLocation: String?
            }
            
            enum Error : Swift.Error{
                case invalidData
                case failure(error: Swift.Error)
                
                var localizedDescription: String{
                    switch self {
                    case .invalidData:
                        return NSLocalizedString("invalidData", comment: "")
                        
                    case let .failure(error):
                        return error.localizedDescription
                    }
                }
            }
        }
    }
    
    struct Sync {
        struct Retrieve {
            struct Request{
                var id :String?
                
                init(id :String?) {
                    self.id = id
                }
            }
        }
    }
}
struct Share {
    
    struct Request
    {
        var id :String
        var title:String
        var description:String
        var image:UIImage?
        var imageURL:URL?
        
        init(id :String,
             title:String,
             description:String,
             image:UIImage? = nil,
             imageURL:URL) {
            self.id = id
            self.title = title
            self.description = description
            self.imageURL = imageURL
        }
        
        init(id :String,
             title:String,
             description:String,
             image:UIImage,
             imageURL:URL? = nil) {
            self.id = id
            self.title = title
            self.description = description
            self.image = image
        }
    }
    
    struct Response
    {
        var id :String
        var title:String
        var description:String
        var image:UIImage?
        var imageURL:URL?
        
        init(id :String,
             title:String,
             description:String,
             image:UIImage? = nil,
             imageURL:URL) {
            self.id = id
            self.title = title
            self.description = description
            self.imageURL = imageURL
        }
        
        init(id :String,
             title:String,
             description:String,
             image:UIImage,
             imageURL:URL? = nil) {
            self.id = id
            self.title = title
            self.description = description
            self.image = image
        }
    }
    
    struct ViewModel
    {
        var id :String
        var title:String
        var description:String
        var image:UIImage?
        var imageURL:URL?
        
    }
    
    
    enum Error:Swift.Error {
        case unknownError
        case shareCancelled
        case configurationMissing
        case invalidData
        case cannotUploadData
        case failure(error:Swift.Error)
        
        var localizedDescription: String{
            switch self {
            case .unknownError:
                return NSLocalizedString("unknownError", comment: "")
            case .shareCancelled:
                return NSLocalizedString("shareCancelled", comment: "")
            case .configurationMissing:
                return NSLocalizedString("configurationMissing", comment: "")
            case .invalidData:
                return NSLocalizedString("InvalidData", comment: "")
            case .cannotUploadData:
                return NSLocalizedString("cannotUploadData", comment: "")
                
            case let .failure(error):
                return error.localizedDescription
            }
        }
    }
}
