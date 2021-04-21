//
//  atmosApp.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI

@main
struct atmosApp: App {
    let shared = SharedData()

    var body: some Scene {
        WindowGroup {
            PlayerView(player: Player(shared: shared))
        }
    }
}
