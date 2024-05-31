//
//  HeTextFieldFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

@objc(HeTextFieldFactory)
class HeTextFieldFactory: NSObject, HeElementFactory {
    static var itemType: HeItemType { .heTextField }
    
    required override init() {}
    
    func create(from data: any HeElementData) -> any HeElement {
        guard let data = data as? HeTextFieldData else {
            fatalError("Invalid data type for HeTextField")
        }
        return HeTextField(data)
    }
    
    func getDataType() -> any HeElementData.Type {
        return HeTextFieldData.self
    }
}
