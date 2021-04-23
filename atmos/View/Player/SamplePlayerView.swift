//
//  SamplePlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct SamplePlayerView: View {
    var category: String
    var sampledSoundSources: [SampledSoundSource]
    
    var body: some View {
        VStack {
            ScrollView (.vertical) {
                ForEach(sampledSoundSources) { sampledSource in
                    PlayerComponent(soundSource: sampledSource)
                        .padding(.horizontal, 10)
                        .padding(.vertical, -5)
                    Divider()
                }
            }
        }
    }
}


struct SamplePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        SamplePlayerView(category: "Weather", sampledSoundSources: SharedData().sampledSoundSources["Weather"]!)
    }
}
