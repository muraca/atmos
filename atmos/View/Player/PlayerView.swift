//
//  PlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct PlayerView: View {
    @StateObject var player: Player
    
    
    var body: some View {
        VStack {
            Menu {
                ForEach(self.player.inactiveSources) { source in
                    Button(source.name, action: { self.player.addSource(sourceID: source.id) })
                }
            } label: {
                Label("Add source", systemImage: "plus")
            }
            
            ScrollView (.horizontal) {
                HStack {
                    ForEach(self.player.activeSources) { source in
                        VStack(alignment: .center) {
                            Button(action: {
                                self.player.removeSource(sourceID: source.id)
                            }) {
                                Circle()
                                    .strokeBorder(Color.red, lineWidth: 1)
                                    .background(Image(systemName: "xmark").foregroundColor(.red))
                                    .frame(width: 30, height: 30)
                            }
                            .padding(.top, 10.0)
                            
                            PlayerComponent(soundSource: source)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                        )
                    }
                }
                .padding()
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(player: Player(shared: SharedData()))
    }
}
