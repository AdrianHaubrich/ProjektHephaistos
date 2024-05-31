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
        
        for element in data.elements {
            switch element.type {
            case .heText:
                if let textData = element as? HeTextData {
                    items.append(HeText(textData))
                }
            case .heTextField:
                if let textFieldData = element as? HeTextFieldData {
                    items.append(HeTextField(textFieldData))
                }
            case .plainHeView:
                if let viewData = element as? HeViewData {
                    items.append(convertToHeView(from: viewData))
                }
            case .cardHeView:
                if let viewData = element as? HeViewData {
                    items.append(convertToCardHeView(from: viewData))
                }
            }
        }
        
        return PlainHeView(items: items)
    }
    
    private func convertToCardHeView(from data: HeViewData) -> any HeView {
        var items: [any HeItem] = []
        
        for element in data.elements {
            switch element.type {
            case .heText:
                if let textData = element as? HeTextData {
                    items.append(HeText(textData))
                }
            case .heTextField:
                if let textFieldData = element as? HeTextFieldData {
                    items.append(HeTextField(textFieldData))
                }
            case .plainHeView:
                if let viewData = element as? HeViewData {
                    items.append(convertToHeView(from: viewData))
                }
            case .cardHeView:
                if let cardViewData = element as? HeViewData {
                    items.append(convertToCardHeView(from: cardViewData))
                }
            }
        }
        
        return CardHeView(items: items)
    }
}
