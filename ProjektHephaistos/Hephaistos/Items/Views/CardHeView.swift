//
//  CardHeView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import SwiftUI

struct CardHeView: HeView {
    let id: String = UUID().uuidString
    var items: [any HeItem]
    
    func getData() -> any HeElementData {
        let elementsData = items.map { $0.getData() }
        return HeViewData(type: .cardHeView,elements: elementsData)
    }
    
    func render() -> AnyView {
        AnyView(
            VStack {
                ForEach(0..<items.count, id: \.self) { index in
                    items[index].render()
                }
            }
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                        .shadow(color: .gray, radius: 10)
                )
                .padding(12)
        )
    }
}
