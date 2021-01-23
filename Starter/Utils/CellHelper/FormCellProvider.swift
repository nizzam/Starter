//
//  FormCellProvider.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

protocol CellModel {}

protocol CellPresentable: UITableViewCell {
    func display(item: CellModel)
}

protocol FormCellProvider {
    var identifier: String { get }
    var cellType: FormCellType { get }
    var cellForm: AnyClass { get }
    
    func isEqual(to: FormCellProvider) -> Bool
}

//  MARK:- Equatable
extension FormCellProvider where Self: Equatable {
    
    func isEqual(to: FormCellProvider) -> Bool {
        return (to as? Self).flatMap { $0 == self } ?? false
    }
}

enum FormCellType {
    case read, input, dropdown, select
}
