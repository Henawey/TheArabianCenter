//
//  Configuration.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/22/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import UIKit

class Configuration {
    
    open let config: NSDictionary?
    
    static let sharedInstance :Configuration = Configuration()
    
    
    private init() {
        
        guard let currentConfigurationName = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
            let currentConfigurationPath = Bundle.main.path(forResource: currentConfigurationName, ofType: "plist"),
            let config = NSDictionary(contentsOfFile: currentConfigurationPath)
            else{
                //unable to load configuration
                fatalError("Configruation missing \n \n please check the following \n 1- \"Configuration\" in info.plist \n 2- plist file named as build configuration selected in schema\n ")
                
        }
        
        self.config = config
    }
    
    func facebookApplink() -> String? {
        return config?.object(forKey:"facebookAppLink") as? String
    }
    
    func twitterAppCardConfigurationLink() -> String? {
        return config?.object(forKey:"twitterAppCardConfigurationLink") as? String
    }
    
    func localizationKitApiKey() -> String?{
        return config?.object(forKey:"localizationKitApiKey") as? String
    }
}
