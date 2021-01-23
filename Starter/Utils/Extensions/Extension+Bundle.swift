//
//  Extension+Bundle.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import Foundation

/// A collection of helpful methods for loading data from our app bundle.
extension Bundle {
    /// Decodes one object type from a JSON filename stored in our bundle.
    func decode<T: Decodable>(_ type: T.Type, from filename: String) -> T? {
        
        guard let json = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }

        guard let jsonData = try? Data(contentsOf: json) else {
            fatalError("Failed to load \(filename) from app bundle.")
        }

        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        decoder.keyDecodingStrategy = .convertFromSnakeCase

//        guard var result = try? decoder.decode(T.self, from: jsonData) else {
//            fatalError("Failed to decode \(filename) from app bundle.")
//        }
        
        do {
            return try decoder.decode(T.self, from: jsonData)
            
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    
    func location<T: Decodable>(_ type: T.Type, from filename: String) -> URL {
        guard let jsonURL = url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in app bundle.")
        }
        return jsonURL
    }
}
