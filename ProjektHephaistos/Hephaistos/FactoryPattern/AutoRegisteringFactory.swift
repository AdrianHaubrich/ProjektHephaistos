//
//  AutoRegisteringFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation
import ObjectiveC.runtime

protocol AutoRegisteringFactory {
    static var itemType: HeItemType { get }
    static func register()
}

extension AutoRegisteringFactory {
    static func register() {
        if let elementFactoryType = self as? HeElementFactory.Type {
            HeItemRegistry.shared.register(elementFactoryType.init(), for: Self.itemType)
        }
        if let viewFactoryType = self as? HeViewFactory.Type {
            HeItemRegistry.shared.register(viewFactoryType.init(), for: Self.itemType)
        }
    }
}

func autoRegisterFactories() {
    // Get the number of all registered classes
    let expectedClassCount = objc_getClassList(nil, 0)
    
    // Allocate memory for the classes
    let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
    defer { allClasses.deallocate() }
    
    // Get the list of all classes
    let actualClassCount = objc_getClassList(AutoreleasingUnsafeMutablePointer(allClasses), expectedClassCount)
    
    // Iterate through all classes
    for i in 0..<Int(actualClassCount) {
        if let currentClass: AnyClass = allClasses[i],
           let autoRegisteringClass = currentClass as? AutoRegisteringFactory.Type {
            autoRegisteringClass.register()
        }
    }
}
