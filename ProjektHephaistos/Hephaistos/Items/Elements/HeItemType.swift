//
//  HeElementType.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import Foundation

enum HeItemType: String, Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case elements
    }
    
    case plainHeView = "plainHeView"
    case cardHeView = "cardHeView"
    
    case heText = "heText"
    case heTextField = "heTextField"
}
