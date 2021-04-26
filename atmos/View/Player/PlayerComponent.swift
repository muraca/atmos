//
//  PlayerComponent.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct PlayerComponent<T: SoundSource>: View {
    @ObservedObject var soundSource: T
    
    init(soundSource: T) {
        self.soundSource = soundSource
        self.soundSource.play()
    }
    
    var body: some View {
        HStack {
            Image(soundSource.image)
                .resizable()
                .frame(width: 70, height: 70)
                .colorInvert()
            
            Slider(value: $soundSource.volume, in: 0.0...1.0)
                .onChange(of: soundSource.volume, perform: { value in
                    soundSource.setVolume(vol: value)
                })
                .padding(.leading, 10)
                .accentColor(.white)
            
            Image(systemName: categoryIcon[self.soundSource.category]!)
                .foregroundColor(.white)
                .font(.title)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(categoryColor[self.soundSource.category]!)
    }
}

struct SamplePlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlayerComponent(soundSource: SampledSoundSource(id: 5, name: "Rain", image: "Rain", soundFile: "Rain.wav"))
    }
}
