//
//  coredataListApp.swift
//  coredataList
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

@main
struct coredataListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
