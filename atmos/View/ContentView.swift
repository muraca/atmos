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
                    HStack {
                        Text(c)
                            .font(.title)
                            .bold()
                            .foregroundColor(categoryColor[c]!)
                        
                        Spacer()
                        
                        Button(action: {
                            shared.mute()
                        }, label: {
                            Image(systemName: "speaker.slash.fill")
                                .font(.title)
                                .foregroundColor(categoryColor[c]!)
                        })
                    }
                    .padding()
                SamplePlayerView(category: c, sampledSoundSources: shared.sampledSoundSources[c]!)
                    
                }
                .navigationTitle(c)
                .tabItem({
                    Image(systemName: categoryIcon[c]!)
                        .foregroundColor(categoryColor[c])
                    Text(c)
                        .font(.subheadline)
                })
                
            }
            UserView(shared: shared)
                .navigationTitle("Hello, \(shared.username)!")
                .tabItem({
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    Text(shared.username.titleCase())
                        .font(.subheadline)
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
