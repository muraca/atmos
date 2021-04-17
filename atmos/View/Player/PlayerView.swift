//
//  PlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct PlayerView: View {
    var engine: AudioEngine
    var mixer: Mixer
    
    var soundSources: [SoundSource]
    
    init() {
        soundSources = [SampledSoundSource(fileName: "Rain.wav"),
                        SampledSoundSource(fileName: "Storm1.wav"),
                        SampledSoundSource(fileName: "Storm2.wav")]
        engine = AudioEngine()
        mixer = Mixer()
        engine.output = mixer
        
        soundSources.forEach { source in
            mixer.addInput(source.getSource()!)
        }
        
        do {
            try engine.start()
        }
        catch {
            print("can't start engine F")
            return;
        }
        
        soundSources.forEach { source in
            source.play()
        }
        
    }
    
    var body: some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(soundSources, id: \.name) { source in
                    PlayerComponent(soundSource: source)
                }
            }
            .padding()
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
