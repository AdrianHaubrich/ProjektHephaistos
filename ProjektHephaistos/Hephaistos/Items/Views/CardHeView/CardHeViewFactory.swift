//
//  CardHeViewFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

@objc(CardHeViewFactory)
class CardHeViewFactory: NSObject, HeViewFactory {
    static var itemType: HeItemType { .cardHeView }
    
    required override init() {}
    
    func create(from data: any HeElementData) -> any HeView {
        guard let data = data as? HeViewData else {
            fatalError("Invalid data type for CardHeView")
        }
        var items: [any HeItem] = []
        for elementData in data.elements {
            if let element = HeItemRegistry.shared.create(from: elementData) {
                items.append(element)
            }
        }
        return CardHeView(items: items)
    }
}
