//
//  HeTextFieldTest.swift
//  ProjektHephaistosTests
//
//  Created by Adrian Haubrich on 31.05.24.
//

import XCTest
@testable import ProjektHephaistos

final class HeTextFieldTests: XCTestCase {
    func testHeTextFieldEncodingDecoding() {
        // Create an instance of HeTextField
        let originalData = HeTextFieldData(placeholder: "Enter text here", text: "Sample text")
        let originalElement = HeTextField(originalData)

        // Encode the HeTextField instance to JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(AnyEncodable(originalElement.getData()))
            // Decode the JSON back to HeTextFieldData
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(HeTextFieldData.self, from: jsonData)

            // Verify that the decoded data matches the original data
            XCTAssertEqual(originalData.type, decodedData.type)
            XCTAssertEqual(originalData.placeholder, decodedData.placeholder)
            XCTAssertEqual(originalData.text, decodedData.text)
        } catch {
            XCTFail("Encoding or decoding failed with error: \(error)")
        }
    }
}
