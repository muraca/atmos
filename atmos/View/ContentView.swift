//
//  ContentView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI

struct ContentView: View {
    var shared: SharedData
    var player: Player
    
    init() {
        self.shared = SharedData()
        self.player = Player(shared: self.shared)
    }
    
    var body: some View {
        TabView {
            ForEach(categories, id: \.self) { c in
                PlayerView(player: Player(shared: shared, category: c))
                    .navigationTitle(c)
                    .tabItem({
                        Image(systemName: categoryIcon[c]!)
                            .foregroundColor(categoryColor[c])
                        Text(c)
                            .font(.subheadline)
                            
                    })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
