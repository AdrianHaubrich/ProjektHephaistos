//
//  CustomHeView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

struct PlainHeView: HeView {
    let id: String = UUID().uuidString
    var elements: [any HeElement]
    
    func getData() -> [any HeElementData] {
        return elements.map { $0.data }
    }
    
    func render() -> AnyView {
        AnyView(
            ForEach(0..<elements.count, id: \.self) { index in
                elements[index].render()
            }
        )
    }
}
