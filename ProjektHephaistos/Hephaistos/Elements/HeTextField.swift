//
//  HeTextField.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

struct HeTextField: HeElement {
    @State var data: HeTextFieldData
    
    init(_ data: HeTextFieldData) {
        self.data = data
    }
    
    func render() -> AnyView {
        AnyView(
            HeTextFieldView(placeholder: data.placeholder, text: $data.text)
        )
    }
}

struct HeTextFieldData: HeElementData {
    var type: HeElementType = .heText
    let placeholder: String
    var text: String
}

struct HeTextFieldView: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
    }
}
