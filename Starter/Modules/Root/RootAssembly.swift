//
//  RootAssembly.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//  Copyright (c) 2021 Nizzam. All rights reserved.

import UIKit

class RootAssembly {

    static func assembleModule() -> UIViewController {
        let view = Storyboard.instantiateView(named: RootController.viewID, from: .main) as! RootController
        
        let router = RootRouter(view: view)
        let interactor = RootInteractor()
        let presenter = RootPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}
