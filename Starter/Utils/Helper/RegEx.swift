//
//  RegEx.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import Foundation

enum RegEx: String {
    case email = "[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    case password
    case confirmPassword
    case none
}
