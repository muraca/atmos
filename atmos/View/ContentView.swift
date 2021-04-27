//
//  ContentView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI

struct ContentView: View {
    var shared: SharedData
    @Environment(\.colorScheme) var globalColorScheme: ColorScheme
    
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
                .tabItem({TabItem(icon: categoryIcon[c]!, title: c)})
                
            }
            
            VStack {
                TitleBar(text: "Waves")
                    .environmentObject(shared)
                
                Text("Binaural")
                    .font(.title)
                    .foregroundColor(categoryColor["Binaural"]!)
                
                SinglePlayerView(category: "Binaural",
                                 soundSources: shared.synthesizedSoundSources["Binaural"]!)
                
                Spacer()
                
                Divider()
                    .frame(width: 0.0, height: 10.0)
                    
                Text("Noises")
                    .font(.title)
                    .foregroundColor(.primary)
                
                MultiplePlayerView(category: "Noise",
                                   soundSources: shared.noiseSoundSources,
                                   scrollable: false)
            }
            .navigationTitle("Waves")
            .tabItem({TabItem(icon: categoryIcon["Noise"]!, title: "Waves")})
            
            VStack {
                TitleBar(text: "User")
                    .environmentObject(shared)
                
                UserView(shared: shared)
                
                Spacer()
            }
            .navigationTitle("User")
            .tabItem({TabItem(icon: "person", title: "User")})
        }
        .preferredColorScheme(globalColorScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(shared: SharedData())
    }
}
