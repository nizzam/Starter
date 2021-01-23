//
//  Extension+Optional.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import Foundation

extension Optional where Wrapped == String {
    
    var unwrapped: String {
        return self ?? ""
    }

    var asInt: Int {
        guard let self = self,
            let intValue = Int(self) else { return 0 }

        return intValue
    }

    var asDouble: Double {
        guard let self = self,
            let intValue = Double(self) else { return 0.0 }

        return intValue
    }
}

extension Optional where Wrapped == NSMutableAttributedString {
    
    var unwrapped: NSMutableAttributedString {
        return self ?? .init()
    }
}

extension Optional where Wrapped == Int {
    
    var valueOrEmpty: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    
    var valueOrEmpty: Double {
        return self ?? 0.0
    }
}

