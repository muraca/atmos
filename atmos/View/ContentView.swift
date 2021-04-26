//
//  ContentView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI

struct ContentView: View {
    var shared: SharedData = SharedData()
    
    var body: some View {
        TabView {
            ForEach(sampleCategories, id: \.self) { c in
                VStack {
                    TitleBar(text: c, color: categoryColor[c]!)
                        .environmentObject(shared)
                    
                    MultiplePlayerView(category: c,
                                       soundSources: shared.sampledSoundSources[c]!)
                    
                    Spacer()
                }
                .navigationTitle(c)
                .tabItem({TabItem(icon: categoryIcon[c]!, color: categoryColor[c]!, title: c)})
                
            }
            
            ForEach(singleSynthCategories, id: \.self) { c in
                VStack {
                    TitleBar(text: c, color: categoryColor[c]!)
                        .environmentObject(shared)
                    
                    SinglePlayerView(category: c,
                                     soundSources: shared.synthesizedSoundSources[c]!)
                    Spacer()
                }
                .navigationTitle(c)
                .tabItem({TabItem(icon: categoryIcon[c]!, color: categoryColor[c]!, title: c)})
            }
            VStack {
                TitleBar(text: "Hello, \(shared.username)!")
                    .environmentObject(shared)
                
                UserView(shared: shared)
                
                Spacer()
            }
            .navigationTitle("User")
            .tabItem({TabItem(icon: "person", title: "User")})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
