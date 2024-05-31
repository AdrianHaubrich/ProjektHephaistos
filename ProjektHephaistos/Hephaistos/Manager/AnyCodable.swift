//
//  AnyCodable.swift
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

struct AnyCodable: Codable {
    let value: any HeElementData

    init(_ value: any HeElementData) {
        self.value = value
    }

    init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let typeContainer = try decoder.container(keyedBy: HeItemType.CodingKeys.self)
            let type = try typeContainer.decode(HeItemType.self, forKey: .type)
            
            switch type {
            case .heText:
                self.value = try container.decode(HeTextData.self)
            case .heTextField:
                self.value = try container.decode(HeTextFieldData.self)
            case .plainHeView:
                self.value = try container.decode(HeViewData.self)
            case .cardHeView:
                self.value = try container.decode(HeViewData.self)
            }
        }

    func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}
