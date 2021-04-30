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
                    TitleBar(text: NSLocalizedString(c, comment: ""), color: categoryColor[c]!)
                        .environmentObject(shared)
                    
                    MultiplePlayerView(category: c,
                                       soundSources: shared.sampledSoundSources[c]!)
                    
                    Spacer()
                }
                .navigationTitle(NSLocalizedString(c, comment: ""))
                .tabItem({TabItem(icon: categoryIcon[c]!, title: NSLocalizedString(c, comment: ""))})
                
            }
            
            VStack {
                TitleBar(text: NSLocalizedString("Waves", comment: ""))
                    .environmentObject(shared)
                
                Text(NSLocalizedString("Binaural", comment: ""))
                    .font(.title)
                    .foregroundColor(categoryColor["Binaural"]!)
                
                SinglePlayerView(category: "Binaural",
                                 soundSources: shared.synthesizedSoundSources["Binaural"]!)
                
                Spacer()
                
                Divider()
                    .frame(width: 0.0, height: 10.0)
                    
                Text(NSLocalizedString("Noises", comment: ""))
                    .font(.title)
                    .foregroundColor(.primary)
                
                MultiplePlayerView(category: "Noise",
                                   soundSources: shared.noiseSoundSources,
                                   scrollable: false)
            }
            .navigationTitle(NSLocalizedString("Waves", comment: ""))
            .tabItem({TabItem(icon: categoryIcon["Noise"]!, title: NSLocalizedString("Waves", comment: ""))})
            
            VStack {
                TitleBar(text: NSLocalizedString("User", comment: ""))
                    .environmentObject(shared)
                
                UserView(shared: shared)
                
                Spacer()
            }
            .navigationTitle(NSLocalizedString("User", comment: ""))
            .tabItem({TabItem(icon: "person", title: NSLocalizedString("User", comment: ""))})
        }
        .preferredColorScheme(globalColorScheme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(shared: SharedData())
    }
}
