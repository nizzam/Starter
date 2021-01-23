//
//  RootPresenter.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//  Copyright (c) 2021 Nizzam. All rights reserved.

import UIKit

class RootPresenter: RootPresenterType {
    
    var view: RootViewType?
    var interactor: RootInputInteractorType?
    var router: RootWireFrameType?
    
    init(view: RootViewType,
         interactor: RootInputInteractorType,
         router: RootWireFrameType) {
        
        self.view = view
        self.interactor = interactor
        self.router = router
    }
	
    func viewDidLoad() {
        // Start here !
    }
}


extension RootPresenter: RootOutputInteractorType {
    
    func didRequestSuccess() {}
    
    func didRequestFailure() {}
}
