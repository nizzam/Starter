//
//  AppDelegate.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //  MARK:- Root
        window = UIWindow()
        
        let vc = RootAssembly.assembleModule()
        
        window?.makeKeyAndVisible()
        window?.rootViewController = Storyboard.instantiateNavigationController(vc: vc)
        
        return true
    }
}

