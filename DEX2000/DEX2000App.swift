//
//  DEX2000App.swift
//  DEX2000
//
//  Created by Simon Wilson on 21/02/2025.
//

import SwiftUI

@main
struct DEX2000App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
