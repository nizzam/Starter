//
//  RootRouter.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//  Copyright (c) 2021 Nizzam. All rights reserved.

import UIKit

class RootRouter: RootWireFrameType {
    
    var viewController: UIViewController?
    
    init(view: UIViewController) {
        self.viewController = view
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func initNavigation() {
        let view = Storyboard.instantiateView(named: RootController.viewID, from: .main) as! RootController
        let router = RootRouter(view: view)
        let interactor = RootInteractor()
        let presenter = RootPresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        view.presenter = presenter
        interactor.output = presenter
        
        setRootVC(view)
    }
    
    private func setRootVC(_ vc: UIViewController) {
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.rootViewController = Storyboard.instantiateNavigationController(vc: vc)
    }
}
