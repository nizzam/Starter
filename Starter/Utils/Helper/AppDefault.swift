//
//  AppDefault.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import Foundation

struct AppDefault {
    
    static private var userDefaults = UserDefaults.standard
    
    enum Key {
        case IS_LOGGED_IN, IS_FIRST_TIME, ACCESS_TOKEN
        
        var desc: String {
            switch self {
            case .IS_LOGGED_IN: return "is_logged_in"
            case .IS_FIRST_TIME: return "is_first_time"
            case .ACCESS_TOKEN: return "access_token"
            }
        }
    }
    
    private static func handleSave(key: Key, value: Any) {
        userDefaults.set(value, forKey: key.desc)
        userDefaults.synchronize()
    }
    
    private static func handleRetrieve(key: Key) -> Any? {
        return userDefaults.object(forKey: key.desc)
    }
    
    private static func handleSaveEntity<T: Codable>(key: Key, entity: T) {
        do {
            let encodedData = try PropertyListEncoder().encode(entity)
            userDefaults.set(encodedData, forKey: key.desc)
            userDefaults.synchronize()
            
        } catch {
            print("Failed to encode (handleSaveEntity): \(key.desc)")
        }
    }
    
    private static func handleRetrieveEntity<T: Codable>(key: Key, entity: T.Type) -> T? {
        do {
            if let data = UserDefaults.standard.object(forKey: key.desc) as? Data {
                return try PropertyListDecoder().decode(T.self, from: data)
            }
            print("Failed to get data (handleRetrieveEntity): \(key.desc)")
            return nil
            
        } catch {
            print("Failed to decode (handleRetrieveEntity): \(key.desc)")
            return nil
        }
    }
}

/// `IsLoggedIn`
extension AppDefault {
    
    static func storeIsLoggedIn(value: Bool) {
        handleSave(key: .IS_LOGGED_IN, value: value)
    }
    
    static func fetchIsLoggedIn() -> Bool {
        handleRetrieve(key: .IS_LOGGED_IN) as? Bool ?? false
    }
}

/// `IsFirstTime`
extension AppDefault {
    
    static func storeIsFirstTime(value: Bool) {
        handleSave(key: .IS_FIRST_TIME, value: value)
    }
    
    static func fetchIsFirstTime() -> Bool {
        handleRetrieve(key: .IS_FIRST_TIME) as? Bool ?? false
    }
}

/// `Access Token`
extension AppDefault {
    
    static func storeAccessToken(value: String) {
        handleSave(key: .ACCESS_TOKEN, value: value)
    }
    
    static func fetchAccessToken() -> String {
        handleRetrieve(key: .ACCESS_TOKEN) as? String ?? ""
    }
}

/// `Reset AppDefault`
extension AppDefault {
    
    static func resetDefaults() {
        let dictionary = userDefaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            userDefaults.removeObject(forKey: key)
        }
    }
}

/// `User`
//extension AppDefault {
//
//    static func storeUserEntity(entity: LoginResponse) {
//        handleSaveEntity(key: .USER, entity: entity)
//    }
//
//    static func fetchUserEntity() -> LoginResponse? {
//        handleRetrieveEntity(key: .USER, entity: LoginResponse.self)
//    }
//}
