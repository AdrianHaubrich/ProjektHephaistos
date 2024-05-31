//
//  AnyHeCodable.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

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

struct AnyHeCodable: Codable {
    let value: any HeElementData
    
    init(_ value: any HeElementData) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let typeContainer = try decoder.container(keyedBy: HeItemType.CodingKeys.self)
        let type = try typeContainer.decode(HeItemType.self, forKey: .type)
        
        if let elementDataType = HeItemRegistry.shared.getElementDataType(type: type) {
            self.value = try container.decode(elementDataType.self)
        } else {
            let dataType = HeItemRegistry.shared.getViewDataType(type: type)
            self.value = try container.decode(dataType)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

