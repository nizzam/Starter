//
//  ListDataSource.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

final class ListDataSource: NSObject {
    
    //  MARK:- Properties
    private let items: [BaseItem]?
    
    //  MARK:- Initializer
    init(items: [BaseItem]) {
        self.items = items
    }
}

//  MARK:- Datasource
extension ListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = items {
            return items.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let items = items {
            let item = items[indexPath.row]
            let type = item.type
            let identifier = type.identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CellPresentable
            decorate(cell, at: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func decorate(_ cell: CellPresentable, at indexPath: IndexPath) {
        if let items = items {
            let item = items[indexPath.row]
            cell.display(item: item)
        }
    }
}
