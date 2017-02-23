//
//  Language.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation
import UIKit

enum Language : String{
    
    case Arabic = "ar"
    case English = "en"
    
    var semanticContentAttribute:UISemanticContentAttribute{
        get{
            switch self {
            case .Arabic:
                return .forceRightToLeft
            case .English:
                return .forceLeftToRight
            }
        }
    }
    struct Request {
        var language:Language
    }
    
}
