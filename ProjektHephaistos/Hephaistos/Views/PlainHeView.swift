//
//  CustomHeView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

struct CustomHeView: HeView {
    let id: String = UUID().uuidString
    var items: [any HeItem]
    
    func getData() -> any HeElementData {
        let elementsData = items.map { $0.getData() }
        return HeViewData(elements: elementsData)
    }
    
    func render() -> AnyView {
        AnyView(
            ForEach(0..<items.count, id: \.self) { index in
                items[index].render()
            }
        )
    }
}
