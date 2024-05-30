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
 * - FIND a way to be able to put groups in groups
 */

struct DemoView: View {
    let heManager: HeManager = ConsoleHeManager()
    let heView: any HeView = PlainHeView(elements: [
        HeText(.init(text: "Text")),
        HeTextField(.init(placeholder: "Enter text here", text: "Some text"))
    ])
    
    var body: some View {
        heView.render()
        
        Button("Print") {
            heManager.save(heView)
        }
    }
}

#Preview {
    DemoView()
}
