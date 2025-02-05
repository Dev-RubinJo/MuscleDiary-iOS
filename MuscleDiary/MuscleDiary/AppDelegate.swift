//
//  AppDelegate.swift
//  MuscleDiary
//
//  Created by YooBin Jo on 2020/04/24.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import Firebase
import AlamofireNetworkActivityIndicator


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        FirebaseApp.configure()
        
        if let _ = UserDefaults.standard.string(forKey: "LoginToken") {
            if #available(iOS 13.0, *) {}
            else {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "MainVC")
                self.window?.rootViewController = mainVC
                self.window?.makeKeyAndVisible()
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}
