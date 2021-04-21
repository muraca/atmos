//
//  PlayerComponent.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct PlayerComponent: View {
    var soundSource: SampledSoundSource
    @State private var volume: Float = 1.0
    
    init(soundSource: SampledSoundSource) {
        self.soundSource = soundSource
        self.soundSource.play()
    }
    
    var body: some View {
            VStack(alignment: .center) {
                HStack {
                    Image(soundSource.image)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .colorInvert()
                    
                    Slider(value: $volume, in: 0.0...1.0)
                        .onChange(of: volume, perform: { value in
                            soundSource.setVolume(vol: volume)
                        })
                        .onAppear { self.volume = self.soundSource.getVolume()
                        }
                        .padding(.horizontal, 10)
                        .accentColor(.white)
                }
                .padding(.vertical, 30)
            }
    }
}

struct PlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlayerComponent(soundSource: SampledSoundSource(id: 5, name: "Rain", image: "Rain", soundFile: "Rain.wav"))
    }
}
