//
//  RootController.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//  Copyright (c) 2021 Nizzam. All rights reserved.

import UIKit

class RootController: UIViewController {
    
    static let viewID = "RootControllerID"
    
	var presenter: RootPresenterType!

	override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
    }
    
    func setupViews() {
        //  Start here !
    }
}

extension RootController: RootViewType {
    
    func update() {}
    func showLoading() {}
    func hideLoading() {}
}
