//
//  SinglePlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import SwiftUI

struct SinglePlayerView<T: SoundSource>: View {
    var category: String
    var soundSources: [T]
    @State var chosen: Int = 0
    
    var body: some View {
        VStack {
            Text(soundSources[chosen].name)
                .font(.title)
                .foregroundColor(categoryColor[category]!)
            
            Divider()
            
            PlayerComponent(soundSource: soundSources[chosen])
                .padding(.horizontal, 10)
                .padding(.vertical, -5)
            
            Divider()
            
            Menu {
                ForEach(soundSources) { source in
                    Button(source.name, action: {
                        let vol = soundSources[chosen].getVolume()
                        soundSources[chosen].setVolume(vol: 0)
                        chosen = source.id
                        soundSources[chosen].setVolume(vol: vol)
                    })
                }
            }
            label: {
                Text("Select source")
                    .font(.title3)
                    .foregroundColor(categoryColor[category]!)
            }
        }
    }
}

struct SinglePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePlayerView(category: "Binaural",
                         soundSources: SharedData().synthesizedSoundSources["Binaural"]!)
    }
}
