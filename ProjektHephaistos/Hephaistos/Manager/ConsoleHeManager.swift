//
//  ConsoleHeManager.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import Foundation

class ConsoleHeManager: HeManager {
    func save(_ heView: any HeView) {
        let data = heView.getData()
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let jsonData = try encoder.encode(data.map { AnyEncodable($0) })
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            print("Failed to encode data to JSON: \(error)")
        }
    }
}

// Wrapper to encode heterogeneous collections
struct AnyEncodable: Encodable {
    private let encodable: Encodable
    
    init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
