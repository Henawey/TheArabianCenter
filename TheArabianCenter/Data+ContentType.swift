//
//  UIImage+Type.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import Foundation

extension Data{
    func contentType() -> String? {
        
        var c = [UInt8](repeating: 0, count: 1)
        self.copyBytes(to: &c, count: 1)
        
        switch (c[0]) {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x42:
            return "image/bmp"
        case  0x49,0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }
}
