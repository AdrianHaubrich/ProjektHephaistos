//
//  HeTextFieldFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

struct HeTextFieldFactory: HeElementFactory {
    func create(from data: any HeElementData) -> any HeElement {
        guard let data = data as? HeTextFieldData else {
            fatalError("Invalid data type for HeTextField")
        }
        return HeTextField(data)
    }
}
