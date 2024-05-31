//
//  ProjektHephaistosApp.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI
import SwiftData

@main
struct ProjektHephaistosApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        // Register factories
        HeItemRegistry.shared.register(HeTextFactory(), for: .heText)
        HeItemRegistry.shared.register(HeTextFieldFactory(), for: .heTextField)
        HeItemRegistry.shared.registerView(PlainHeViewFactory(), for: .plainHeView)
        HeItemRegistry.shared.registerView(CardHeViewFactory(), for: .cardHeView)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
