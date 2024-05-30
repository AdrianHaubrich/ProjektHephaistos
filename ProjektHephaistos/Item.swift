//
//  Item.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
