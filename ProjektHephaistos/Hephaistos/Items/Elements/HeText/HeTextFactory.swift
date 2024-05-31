//
//  HeTextFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

struct HeTextFactory: HeElementFactory {
    func create(from data: any HeElementData) -> any HeElement {
        guard let data = data as? HeTextData else {
            fatalError("Invalid data type for HeText")
        }
        return HeText(data)
    }
}
