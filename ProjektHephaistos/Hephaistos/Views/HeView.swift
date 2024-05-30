//
//  HeView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

protocol HeView: Identifiable {
    var elements: [any HeElement] { get set }
    
    func getData() -> [any HeElementData]
    @ViewBuilder func render() -> AnyView
}
