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


struct Sync {
    
    struct Save {
        struct Request : Mappable{
            var title:String
            var description:String
            var imageLocation:String?
            var image:UIImage?
            var lat:Double?
            var long:Double?
            
            init(title:String,
                 description:String,
                  image:UIImage,
                  location:CLLocation?) {
                self.title = title
                self.description = description
                self.image = image
                lat = location?.coordinate.latitude
                long = location?.coordinate.longitude
            }
            
            init?(map: Map) {
                guard let title = map.JSON["title"] as? String,
                    let description = map.JSON["description"] as? String,
                    let imageLocation = map.JSON["imageLocation"] as? String
                    else{
                        return nil
                }
                self.title = title
                self.description = description
                self.imageLocation = imageLocation
            }
            
            mutating func mapping(map: Map) {
                title <- map["title"]
                description <- map["description"]
                imageLocation <- map["imageLocation"]
                lat <- map["location.lat"]
                long <- map["location.long"]
            }
        }
    }
    
    struct Retrieve {
        struct Request{
            var id :String
            
            init(id :String) {
                self.id = id
            }
        }
    }
    
    struct Response: Mappable
    {
        var id :String
        var title:String
        var description:String
        var imageLocation:String
        var image:UIImage?
        
        init(id :String,
             title:String,
             description:String,
             imageLocation:String) {
            self.id = id
            self.title = title
            self.description = description
            self.imageLocation = imageLocation
        }
        init?(map: Map) {
            guard let id = map.JSON["id"] as? String,
                let title = map.JSON["title"] as? String,
                let description = map.JSON["description"] as? String,
                let imageLocation = map.JSON["imageLocation"] as? String
                else{
                    return nil
            }
            self.id = id
            self.title = title
            self.description = description
            self.imageLocation = imageLocation
        }
        
        mutating func mapping(map: Map) {
            id <- map["id"]
            title <- map["title"]
            description <- map["description"]
            imageLocation <- map["imageLocation"]
        }
    }
    
    struct ViewModel
    {
        var id :String
        var title:String
        var description:String
        var imageLocation:String
    }
    enum Error:Swift.Error {
        case unknownError
        case configurationMissing
        case invalidData
        case failure(error:Swift.Error)
    }
}

struct Share {
    struct UI {
        struct Request
        {
            var id:String?
            var title:String?
            var description:String?
            var image:UIImage?
            var imageURL:URL?
            
            init(id :String? = nil,
                 title:String? = nil,
                 description:String? = nil,
                 image:UIImage? = nil,
                 imageURL:URL? = nil) {
                
                self.id = id
                self.title = title
                self.description = description
                self.image = image
                self.imageURL = imageURL
            }
        }
        
    }
    
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
    
    
    enum Error:Swift.Error {
        case unknownError
        case shareCancelled
        case configurationMissing
        case invalidData
        case failure(error:Swift.Error)
    }
}
