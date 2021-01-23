//
//  RootProtocol.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//  Copyright (c) 2021 Nizzam. All rights reserved.

import UIKit

protocol RootViewType: class {
    
    func update()
    func showLoading()
    func hideLoading()
}

protocol RootPresenterType: class {
    
    func viewDidLoad()
}

protocol RootInputInteractorType: class {
    
    var output: RootOutputInteractorType? { get set }
    
    func performRequest()
}

protocol RootOutputInteractorType: class {
    
    func didRequestSuccess()
    func didRequestFailure()
}

protocol RootWireFrameType: class {
    

}
