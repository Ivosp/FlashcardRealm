//
//  AppDelegate.swift
//  FlashcardRealm
//
//  Created by Ivo Specht on 05/04/2020.
//  Copyright © 2020 Ivo Specht. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemIndigo
        
            appearance.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]

            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.buttonAppearance = buttonAppearance

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance

            UIBarButtonItem.appearance().tintColor = UIColor.white
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.black
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
            UINavigationBar.appearance().tintColor = UIColor.white

            UIBarButtonItem.appearance().tintColor = UIColor.white
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

