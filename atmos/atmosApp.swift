//
//  atmosApp.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI

@main
struct atmosApp: App {
    var shared: SharedData = SharedData()
    
    var body: some Scene {
        WindowGroup {
            ContentView(shared: shared)
        }
    }
}
