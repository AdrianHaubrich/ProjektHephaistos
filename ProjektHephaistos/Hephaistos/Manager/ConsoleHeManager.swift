//
//  ConsoleHeManager.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import Foundation

class ConsoleHeManager: HeManager {
    func save(_ heView: any HeView) {
        let data = heView.getData()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let jsonData = try? encoder.encode(AnyEncodable(data)),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    }
    
    func load(from jsonString: String) -> (any HeView)? {
        let decoder = JSONDecoder()
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed to convert JSON string to data")
            return nil
        }
        
        do {
            let heViewData = try decoder.decode(HeViewData.self, from: jsonData)
            return convertToHeView(from: heViewData)
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
    
    private func convertToHeView(from data: HeViewData) -> any HeView {
        var items: [any HeItem] = []
        
        for elementData in data.elements {
            if let element = HeItemRegistry.shared.create(from: elementData) {
                items.append(element)
            }
        }
        
        return PlainHeView(items: items)
    }
}
