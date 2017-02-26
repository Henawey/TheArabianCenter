//
//  AppDelegate.swift
//  TheArabianCenter
//
//  Created by Ahmed Henawey on 2/19/17.
//  Copyright © 2017 Ahmed Henawey. All rights reserved.
//

import UIKit

import Bolts
import Fabric
import TwitterKit
import Firebase
import URLNavigator
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        Fabric.with([Twitter.self])
        
        Navigator.map("thearabiancenterpromoCodeByFB://") { url, _ in
            
            guard let bfURL = BFURL(url: url.urlValue) ,
                let appLinkData =  bfURL.appLinkData["target_url"] as? String,
                let url = URL(string: appLinkData),
                let query = url.query else{
               return false
            }
            
            let components = query.components(separatedBy: "=")
            
            if components.count < 2{
                return false
            }
            
            let offerId = components[1]

            let initialViewController: UINavigationController =   UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            let sharerViewController :ShareViewController =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sharer") as! ShareViewController
            
            self.window?.rootViewController = initialViewController
            
            sharerViewController.loadOffer(offerId: offerId)
            
            initialViewController.pushViewController(sharerViewController, animated: true)
            return true
        }
        
        Navigator.map("thearabiancenterpromocodebytwitter://") { url, values in
            
            guard let url = url.urlValue,
                let query = url.query else{
                    return false
            }
            
            let components = query.components(separatedBy: "=")
            
            if components.count < 2{
                return false
            }
            
            let offerId = components[1]

            let initialViewController: UINavigationController =   UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            let sharerViewController :ShareViewController =   UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sharer") as! ShareViewController
            
            self.window?.rootViewController = initialViewController
            
            sharerViewController.loadOffer(offerId: offerId)
            
            initialViewController.pushViewController(sharerViewController, animated: true)
            return true
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.localizationChanged), name: NSNotification.Name(rawValue: "localizationChanged"), object: nil)
        
        
        return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return Navigator.open(url) || SDKApplicationDelegate.shared.application(app, open: url, options: options)
        
    }
    
    func localizationChanged(notification:Notification) {
        self.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
    }
}

