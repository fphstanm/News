//
//  AppDelegate.swift
//  News
//
//  Created by Philip on 29.03.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
        RealmService.writeArticles(DataStore.shared.getArticles())
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
        RealmService.writeArticles(DataStore.shared.getArticles())
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
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
        RealmService.writeArticles(DataStore.shared.getArticles())
    }
    
    


}

