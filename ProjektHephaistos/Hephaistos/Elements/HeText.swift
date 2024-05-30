//
//  HeText.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

struct HeText: HeElement {
    var data: HeTextData
    
    init(_ data: HeTextData) {
        self.data = data
    }
    
    func render() -> AnyView {
        AnyView(
            HeTextView(text: data.text)
        )
    }
}

struct HeTextData: HeElementData {
    var type: HeElementType = .heText
    let text: String
}

struct HeTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
    }
}
