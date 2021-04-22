//
//  PlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

var categories: [String] = [
    "Sea",
    "Weather",
    "Nature",
    "Binaural"
]

var categoryIcon: [String:String] = [
    "Sea" : "drop",
    "Weather" : "cloud.sun",
    "Nature" : "leaf",
    "Binaural" : "waveform"
]

var categoryColor: [String:Color] = [
    "Sea" : .blue,
    "Nature" : .green,
    "Weather" : .gray,
    "Binaural" : .purple,
    "" : .black
]

struct PlayerView: View {
    @StateObject var player: Player
    
    var body: some View {
        VStack {
            if self.player.category == "" {
                HStack {
                    Text("Custom preset")
                        .font(.title)
                        .bold()
                        .foregroundColor(categoryColor[self.player.category])
                    
                    Spacer()
                    
                    Button(action: {
                        
                    },
                        label: {
                            Text("Save")
                        })
                    
                }
                .padding()
                
                Menu {
                    ForEach(self.player.inactiveSources) { source in
                        Button(source.name, action: { self.player.addSource(sourceID: source.id) })
                    }
                } label: {
                    Label("Add source", systemImage: "plus")
                }
            }
            else {
                HStack {
                    Text(self.player.category)
                        .font(.title)
                        .bold()
                        .foregroundColor(categoryColor[self.player.category])
                    
                    Spacer()
                }
                .padding()
            }
            
            ScrollView (.vertical) {
                ForEach(self.player.activeSources) { source in
                    HStack(alignment: .center) {
                        PlayerComponent(soundSource: source)
                        
                        if self.player.category == "" {
                            Button(action: {
                                self.player.removeSource(sourceID: source.id)
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        else {
                            Image(systemName: categoryIcon[self.player.category]!)
                                .foregroundColor(.white)
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(categoryColor[source.category])
                    
                    Divider()
                }
            }
        }
    }
    }


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(shared: SharedData(), activeSourcesIDs: [0,1,2]))
    }
}
