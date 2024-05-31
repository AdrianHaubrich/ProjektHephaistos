//
//  HeTextField.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

struct HeTextField: HeElement {
    @ObservedObject var observedData: ObservedHeTextFieldData<HeTextFieldData>
    
    init(_ data: HeTextFieldData) {
        self.observedData = ObservedHeTextFieldData(data: data)
    }
    
    func getData() -> any HeElementData {
        return observedData.data
    }
    
    func render() -> AnyView {
        AnyView(
            HeTextFieldView(placeholder: observedData.data.placeholder, text: $observedData.data.text)
        )
    }
}

class ObservedHeTextFieldData<DataType: HeElementData>: ObservableObject {
    @Published var data: DataType
    
    init(data: DataType) {
        self.data = data
    }
}

struct HeTextFieldData: HeElementData {
    var type: HeItemType = .heTextField
    var placeholder: String
    var text: String
    
    init(placeholder: String, text: String) {
        self.placeholder = placeholder
        self.text = text
    }
}

struct HeTextFieldView: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
    }
}
