//
//  HeTextTests.swift
//  ProjektHephaistosTests
//
//  Created by Adrian Haubrich on 31.05.24.
//

import XCTest
@testable import ProjektHephaistos

final class HeTextTests: XCTestCase {
    func testHeTextEncodingDecoding() {
        // Create an instance of HeText
        let originalData = HeTextData(type: .heText, text: "Sample text")
        let originalElement = HeText(originalData)

        // Encode the HeText instance to JSON
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(AnyEncodable(originalElement.getData()))
            // Decode the JSON back to HeTextData
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(HeTextData.self, from: jsonData)

            // Verify that the decoded data matches the original data
            XCTAssertEqual(originalData.type, decodedData.type)
            XCTAssertEqual(originalData.text, decodedData.text)

            // Optionally, recreate the HeText element and verify
            let recreatedElement = HeText(decodedData)
            XCTAssertEqual(recreatedElement.data.text, originalElement.data.text)

        } catch {
            XCTFail("Encoding or decoding failed with error: \(error)")
        }
    }
}
