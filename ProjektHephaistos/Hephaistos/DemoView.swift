//
//  DemoView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

struct DemoView: View {
    let heManager: HeManager = ConsoleHeManager()
    @State var heItem: any HeItem = PlainHeView(items: [
        HeText(.init(text: "Text")),
        HeTextField(.init(placeholder: "Enter text here", text: "Some text")),
        CardHeView(items: [
            HeText(.init(text: "Nested Text")),
            HeTextField(.init(placeholder: "Nested enter text", text: "Nested text"))
        ])
    ])
    
    var body: some View {
        VStack {
            heItem.render()
            
            Button("Print") {
                heManager.save(heItem)
            }
            
            Button("Load") {
                let data = """
              {
                "type" : "cardHeView",
                "elements" : [
                  {
                    "type" : "heText",
                    "text" : "Text"
                  },
                  {
                    "type" : "heText",
                    "text" : "Text"
                  },
                  {
                    "text" : "Some text",
                    "placeholder" : "Enter text here",
                    "type" : "heTextField"
                  },
                  {
                    "type" : "cardHeView",
                    "elements" : [
                      {
                        "type" : "heText",
                        "text" : "Nested Text"
                      },
                      {
                        "type" : "heTextField",
                        "placeholder" : "Nested enter text",
                        "text" : "Nested text"
                      }
                    ]
                  }
                ]
              }
"""
                heItem = heManager.load(from: data)!
            }
        }
    }
}

#Preview {
    DemoView()
}
