//
//  HomeModels.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/18/17.
//  Copyright (c) 2017 Ahmed Henawey. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

struct Home
{
    struct Offer
    {
        struct Share {
            
            struct Request
            {
                var title:String
                var description:String
                var extra:[String:String]?
            }
            struct Response
            {
                var title:String
                var description:String
                var extra:[String:String]?
            }
            
            enum Error:Swift.Error {
                case UnknownError
                case ShareCancelled
                case failure(error:Swift.Error)
            }
        }
        struct Request
        {
        }
        struct Response
        {
            var id:String?
        }
        struct ViewModel
        {
            var id:String
            var title:String
            var description:String
        }
    }
    enum Error:Swift.Error {
        case failure(error:Swift.Error)
    }
    
}
