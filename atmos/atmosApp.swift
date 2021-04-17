//
//  atmosApp.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI

@main
struct atmosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
