//
//  FormItem.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

class FormItem: BaseItem {
    
    /// Input
    var title: NSMutableAttributedString
    var inputValue: NSMutableAttributedString
    var placeholder: String
    
    /// Control
    var isRequired: Bool
    var isEnabled: Bool
    var validationType: RegEx
    var characterType: CharacterControl
    var keyboardType: UIKeyboardType
    var characterMin: Int
    var characterMax: Int
    
    /// UI
    var rightIcon: UIImage? ///  -->  Display clear button
    var secureEntry: Bool /// --> For Password (•••••••)
    
    /// Country
    var countryFlag: UIImage?
    var countryCode: String
    
    /// Error
    var isError: Bool
    var errorValue: String?
    var errorColor: UIColor
    
    /// Handler
    var handlerValidate: (()->Void)?
    var handlerShow: (()->Void)? /// --> For Password (Show/Hide)
    
    /// Initializer
    init(type: FormCellProvider,
         backgroundColor: UIColor = .clear,
         
         title: NSMutableAttributedString = .init(),
         inputValue: NSMutableAttributedString = .init(),
         placeholder: String = "",

         isRequired: Bool = true,
         isEnabled: Bool = true,
         validationType: RegEx = .none,
         characterType: CharacterControl = .none,
         keyboardType: UIKeyboardType = .default,
         characterMin: Int = 1,
         characterMax: Int = 1000,
         
         rightIcon: UIImage? = nil,
         secureEntry: Bool = false,

         isError: Bool = false,
         errorValue: String? = nil,
         errorColor: UIColor = UIColor.red,
         
         countryFlag: UIImage? = nil,
         countryCode: String = "") {
        
        self.title = title
        self.inputValue = inputValue
        self.placeholder = placeholder

        self.isRequired = isRequired
        self.isEnabled = isEnabled
        self.validationType = validationType
        self.characterType = characterType
        self.keyboardType = keyboardType
        self.characterMin = characterMin
        self.characterMax = characterMax
        
        self.rightIcon = rightIcon
        self.secureEntry = secureEntry

        self.isError = isError
        self.errorValue = errorValue
        self.errorColor = errorColor
        
        self.countryFlag = countryFlag
        self.countryCode = countryCode
        
        super.init(type: type, backgroundColor: backgroundColor)
    }
}
