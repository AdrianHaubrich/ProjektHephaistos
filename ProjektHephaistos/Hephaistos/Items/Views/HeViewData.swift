//
//  HeViewData.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

struct HeViewData: HeElementData {
    var type: HeItemType
    var elements: [any HeElementData]
}

extension HeViewData: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case elements
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        
        var elementsContainer = container.nestedUnkeyedContainer(forKey: .elements)
        for element in elements {
            try elementsContainer.encode(AnyEncodable(element))
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(HeItemType.self, forKey: .type)
        
        var elementsContainer = try container.nestedUnkeyedContainer(forKey: .elements)
        var elements = [any HeElementData]()
        
        while !elementsContainer.isAtEnd {
            let element = try elementsContainer.decode(AnyCodable.self).value
            switch element.type {
            case .heText:
                if let element = element as? HeTextData {
                    elements.append(element)
                }
            case .heTextField:
                if let element = element as? HeTextFieldData {
                    elements.append(element)
                }
            case .plainHeView:
                if let element = element as? HeViewData {
                    elements.append(element)
                }
            case .cardHeView:
                if let element = element as? HeViewData {
                    elements.append(element)
                }
            }
        }
        
        self.elements = elements
    }
}
