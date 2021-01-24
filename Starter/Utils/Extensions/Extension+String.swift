//
//  Extension+String.swift
//  Starter
//
//  Created by Nizzammuddin on 24/01/2021.
//

import Foundation

extension String {
    
    func isValid(_ pattern: RegEx) -> Bool {
        if pattern == .none {
            return !self.isEmpty
        } else if pattern == .confirmPassword {
            return self.isValid(.password) && !self.isEmpty
        }
        return NSPredicate(format:"SELF MATCHES %@", pattern.rawValue).evaluate(with: self)
    }
    
    /// For credit card
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
       let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
       return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
       }.joined().dropFirst())
    }
}
