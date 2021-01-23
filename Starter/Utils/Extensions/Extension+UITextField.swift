//
//  Extension+UITextField.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

extension UITextField {
    
    public func withPlaceholder(color: UIColor, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(
            string: self.placeholder != nil ? self.placeholder! : "",
            attributes: [NSAttributedString.Key.foregroundColor: color,
                         NSAttributedString.Key.font: font]
        )
    }
    
    public func setText(to newText: String, preservingCursor: Bool) {
        if preservingCursor {
            let cursorPosition = offset(from: beginningOfDocument, to: selectedTextRange!.start) +
                newText.count - (text?.count ?? 0)
            text = newText
            if let newPosition = self.position(from: beginningOfDocument, offset: cursorPosition) {
                selectedTextRange = textRange(from: newPosition, to: newPosition)
            }
            
        } else {
            text = newText
        }
    }
}
