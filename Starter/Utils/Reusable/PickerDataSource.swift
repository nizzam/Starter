//
//  PickerDataSource.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

class PickerDataSource: NSObject {
    
    // MARK: - Properties
    let items: [PickerEntity]
    
    // MARK: - Initalizer
    init(items: [PickerEntity]) {
        self.items = items
    }
}

//  MARK: - PickerViewDataSource
extension PickerDataSource: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
}

//  MARK: - PickerViewDelegate
extension PickerDataSource:  UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].value
    }
}

struct PickerEntity {
    let id: Int
    let value: String
}
