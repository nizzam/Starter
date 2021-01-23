//
//  Storyboard.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit
import SafariServices

struct Storyboard {
    
    enum Name: String {
        case main = "Main"
    }
    
    static func instantiateView(named view: String, from storyboard: Name) -> UIViewController {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: view)
    }
    
    static func instantiateNavigationController(vc: UIViewController, style: UIModalPresentationStyle = .fullScreen) -> UINavigationController {
        let navigation = Storyboard.instantiateView(named: "BaseControllerID", from: .main) as! UINavigationController
        navigation.modalPresentationStyle = style
        navigation.setViewControllers([vc], animated: true)
        return navigation
    }
    
    static func instantiateSafari(url: URL) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    static func getPresentedViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
