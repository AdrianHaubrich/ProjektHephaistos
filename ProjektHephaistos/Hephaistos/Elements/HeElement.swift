//
//  HeElement.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

protocol HeElement {
    associatedtype DataType: HeElementData
    var data: DataType { get set }
    
    @ViewBuilder func render() -> AnyView
}

protocol HeElementData: Codable {
    var type: HeElementType { get }
}
