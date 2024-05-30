//
//  DemoView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

/* TODO:
 * - Change Views to Groups and HeView to HeGroup; add e.g. HeCardGroup
 * - Add View and HeView to manage a collection of HeGroups
 */

protocol HeItem {
    func getData() -> any HeElementData
    @ViewBuilder func render() -> AnyView
}

struct HeViewData: HeElementData {
    var type: HeElementType = .heView
    var elements: [any HeElementData]
}

extension HeViewData: Codable {
    enum CodingKeys: String, CodingKey {
        case type
        case elements
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        
        var elementsContainer = container.nestedUnkeyedContainer(forKey: .elements)
        for element in elements {
            let encodable = AnyEncodable(element)
            try elementsContainer.encode(encodable)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(HeElementType.self, forKey: .type)
        
        var elementsContainer = try container.nestedUnkeyedContainer(forKey: .elements)
        var elements = [any HeElementData]()
        
        while !elementsContainer.isAtEnd {
            if let element = try? elementsContainer.decode(HeTextData.self) {
                elements.append(element)
            } else if let element = try? elementsContainer.decode(HeTextFieldData.self) {
                elements.append(element)
            } else if let element = try? elementsContainer.decode(HeViewData.self) {
                elements.append(element)
            }
        }
        
        self.elements = elements
    }
}

struct DemoView: View {
    let heManager: HeManager = ConsoleHeManager()
    let heView: any HeView = CustomHeView(items: [
        HeText(.init(text: "Text")),
        HeTextField(.init(placeholder: "Enter text here", text: "Some text")),
        CustomHeView(items: [
            HeText(.init(text: "Nested Text")),
            HeTextField(.init(placeholder: "Nested enter text", text: "Nested text"))
        ])
    ])
    
    var body: some View {
        VStack {
            heView.render()
            
            Button("Print") {
                heManager.save(heView)
            }
        }
    }
}

#Preview {
    DemoView()
}
