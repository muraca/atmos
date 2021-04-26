//
//  SingleSynthesizedPlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import SwiftUI

struct SingleSynthesizedPlayerView: View {
    var category: String
    var synthesizedSoundSources: [SynthesizedSoundSource]
    @State var chosen: Int = 0
    
    var body: some View {
        VStack {
            Text(synthesizedSoundSources[chosen].name)
                .font(.title)
                .foregroundColor(categoryColor[category]!)
            
            Divider()
            
            PlayerComponent(soundSource: synthesizedSoundSources[chosen])
                .padding(.horizontal, 10)
                .padding(.vertical, -5)
            
            Divider()
            
            Menu {
                ForEach(synthesizedSoundSources) { source in
                    Button(source.name, action: {
                        let vol = synthesizedSoundSources[chosen].getVolume()
                        synthesizedSoundSources[chosen].setVolume(vol: 0)
                        chosen = source.id
                        synthesizedSoundSources[chosen].setVolume(vol: vol)
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

struct SingleSynthesizedPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SingleSynthesizedPlayerView(category: "Binaural", synthesizedSoundSources: SharedData().synthesizedSoundSources["Binaural"]!)
    }
}
