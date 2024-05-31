//
//  CardHeViewTests.swift
//  ProjektHephaistosTests
//
//  Created by Adrian Haubrich on 31.05.24.
//

import XCTest
@testable import ProjektHephaistos

final class CardHeViewTests: XCTestCase {
    func testCardHeViewEncodingDecoding() {
        // Create instances of elements
        let textData = HeTextData(text: "Sample text")
        let textFieldData = HeTextFieldData(placeholder: "Enter text here", text: "Sample text")
        
        let textElement = HeText(textData)
        let textFieldElement = HeTextField(textFieldData)
        
        // Create an instance of CardHeView
        let originalViewData = HeViewData(type: .cardHeView, elements: [textData, textFieldData])
        let originalView = CardHeView(items: [textElement, textFieldElement])

        // Encode the CardHeView instance to JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(AnyEncodable(originalView.getData()))
            // Decode the JSON back to CardHeViewData
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(HeViewData.self, from: jsonData)

            // Verify that the decoded data matches the original data
            XCTAssertEqual(originalViewData.type, decodedData.type)
            XCTAssertEqual(originalViewData.elements.count, decodedData.elements.count)

            // Optionally, recreate the CardHeView and verify
            var recreatedItems: [any HeItem] = []
            for elementData in decodedData.elements {
                if let element = HeItemRegistry.shared.create(from: elementData) {
                    recreatedItems.append(element)
                }
            }
            let recreatedView = CardHeView(items: recreatedItems)
            XCTAssertEqual(recreatedView.items.count, originalView.items.count)

        } catch {
            XCTFail("Encoding or decoding failed with error: \(error)")
        }
    }
}
