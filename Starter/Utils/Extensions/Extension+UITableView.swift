//
//  Extension+UITableView.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

extension UITableView {
    
    enum Cell: String, CaseIterable {
        case TABLE_CELL = "TableCell"
        
        var value: String {
            self.rawValue
        }
    }
    
    func reloadWithoutAnimation(_ indexPath: IndexPath) {
        let lastScrollOffset = contentOffset
        reloadRows(at: [indexPath], with: .none)
        layer.removeAllAnimations()
        setContentOffset(lastScrollOffset, animated: false)
    }
    
    func registerCell() {
        backgroundColor = .clear
        tableFooterView = UIView()
        separatorStyle = .none

        Cell.allCases.forEach {
            self.register(UINib(nibName: $0.value, bundle: nil), forCellReuseIdentifier: $0.value)
        }
    }
}

extension UITableViewCell {
    
    func clear() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
