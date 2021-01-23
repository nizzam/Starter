//
//  Extension+NSMutableAttributedString.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

extension NSMutableAttributedString {
    
    func text(_ value: String, color: UIColor = .black, font: UIFont, alignment: NSTextAlignment = .left) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        
        let attributes:[NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func underlined(_ value: String, color: UIColor = .black, font: UIFont) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .underlineStyle: (NSUnderlineStyle.thick.rawValue | NSUnderlineStyle.patternDot.rawValue)
        ]
        self.append(NSAttributedString(string: value, attributes: attributes))
        return self
    }
    
    func strikeThrough(value: String)->NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: value)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
