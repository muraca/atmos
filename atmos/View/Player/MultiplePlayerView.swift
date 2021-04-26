//
//  MultiplePlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct MultiplePlayerView<T: SoundSource>: View {
    var category: String
    var soundSources: [T]
    
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                ForEach(soundSources) { source in
                    PlayerComponent(soundSource: source)
                        .padding(.horizontal, 10)
                        .padding(.vertical, -5)
                    Divider()
                }
            }
        }
    }
}


struct MultiplePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplePlayerView(category: "Weather",
                           soundSources: SharedData().sampledSoundSources["Weather"]!)
    }
}
