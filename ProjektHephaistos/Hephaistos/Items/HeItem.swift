//
//  HeItem.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import SwiftUI

protocol HeItem {
    func getData() -> any HeElementData
    @ViewBuilder func render() -> AnyView
}
