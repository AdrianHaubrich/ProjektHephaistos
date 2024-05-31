//
//  HeItemRegistry.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

class HeItemRegistry {
    static let shared = HeItemRegistry()
    private var factories: [HeItemType: HeElementFactory] = [:]
    private var viewFactories: [HeItemType: HeViewFactory] = [:]
    
    private init() {}
    
    func register<T: HeElementFactory>(_ factory: T, for type: HeItemType) {
        factories[type] = factory
    }
    
    func register<T: HeViewFactory>(_ factory: T, for type: HeItemType) {
        viewFactories[type] = factory
    }
    
    func create(from data: any HeElementData) -> (any HeItem)? {
        if let factory = factories[data.type] {
            return factory.create(from: data)
        } else if let factory = viewFactories[data.type] {
            return factory.create(from: data)
        }
        return nil
    }
}
