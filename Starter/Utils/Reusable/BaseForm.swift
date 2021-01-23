//
//  BaseForm.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import Foundation

class BaseForm {
    
    var items: [BaseItem] {
        return []
    }
    
    var dataSource: ListDataSource {
        return ListDataSource(items: items)
    }
    
    /// General validation for form textfield
    func validation(_ item: FormItem,
                    errorDesc1: String,
                    errorDesc2: String) -> Bool {
        
        if item.isRequired && item.inputValue.string.isEmpty {
            item.isError = true
            item.errorValue = errorDesc1
            return false
            
        } else if item.isRequired && item.inputValue.string.count < item.characterMin {
            item.isError = true
            item.errorValue = errorDesc2
            return false
            
        } else {
            item.isError = false
            item.errorValue = ""
            return true
        }
    }
}
