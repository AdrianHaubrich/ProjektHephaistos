//
//  HeTextFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

@objc(HeTextFactory)
class HeTextFactory: NSObject, HeElementFactory {
    static var itemType: HeItemType { .heText }
    
    required override init() {}
    
    func create(from data: any HeElementData) -> any HeElement {
        guard let data = data as? HeTextData else {
            fatalError("Invalid data type for HeText")
        }
        return HeText(data)
    }
    
    func getDataType() -> any HeElementData.Type {
        return HeTextData.self
    }
}
