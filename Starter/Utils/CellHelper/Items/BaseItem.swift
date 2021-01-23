//
//  BaseItem.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

class BaseItem: CellModel {
    
    /// Type
    var type: FormCellProvider
    
    /// UI
    var backgroundColor: UIColor
    
    /// Action / Handler
    var handler: (()->Void)?
    
    /// Initializer
    init(type: FormCellProvider,
         backgroundColor: UIColor = .clear,
         handler: (()->Void)? = nil) {
        
        self.type = type
        self.backgroundColor = backgroundColor
        self.handler = handler
    }
}
