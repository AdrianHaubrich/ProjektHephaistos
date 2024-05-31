//
//  HeElement.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

protocol HeElement: HeItem {
    @ViewBuilder func render() -> AnyView
}

protocol HeElementData: Codable {
    var type: HeItemType { get }
}
