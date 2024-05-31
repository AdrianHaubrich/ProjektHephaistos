//
//  ConsoleHeManager.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import Foundation

class ConsoleHeManager: HeManager {
    func save(_ heItem: any HeItem) {
        let data = heItem.getData()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        if let jsonData = try? encoder.encode(AnyEncodable(data)),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    }
    
    func load(from jsonString: String) -> (any HeItem)? {
        let decoder = JSONDecoder()
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Failed to convert JSON string to data")
            return nil
        }
        
        do {
            let heViewData = try decoder.decode(HeViewData.self, from: jsonData)
            return convertToHeItem(from: heViewData)
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
    
    private func convertToHeItem(from data: HeViewData) -> any HeItem {
        var items: [any HeItem] = []
        
        for elementData in data.elements {
            if let element = HeItemRegistry.shared.create(from: elementData) {
                items.append(element)
            }
        }
        
        if let outerElement = HeItemRegistry.shared.create(from: data) {
            if var outerView = outerElement as? (any HeView) {
                outerView.items = items
                
                return outerView
            } else {
                return outerElement
            }
        }
        
        return PlainHeView(items: items)
    }
}
