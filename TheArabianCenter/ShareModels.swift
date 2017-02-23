//
//  ShareModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation
import UIKit

struct Share {
    struct Request
    {
        var id :String
        var title:String
        var description:String
        var image:UIImage
        var extra:[String:Any]?
        
        init(id :String,
             title:String,
               description:String,
               image:UIImage,
               extra:[String:Any]? = [:]) {
            self.id = id
            self.title = title
            self.description = description
            self.image = image
            self.extra = extra
        }
    }
    struct Response
    {
        var title:String
        var description:String
        var extra:[String:Any]?
    }
    
    struct ViewModel
    {
        var id:String
        var title:String
        var description:String
    }

    
    enum Error:Swift.Error {
        case unknownError
        case shareCancelled
        case configurationMissing
        case failure(error:Swift.Error)
    }
}
