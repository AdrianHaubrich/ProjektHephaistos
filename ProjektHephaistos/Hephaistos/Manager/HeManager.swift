//
//  HeManager.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import Foundation

protocol HeManager {
    func save(_ heItem: any HeItem)
    func load(from jsonString: String) -> (any HeItem)?
}
