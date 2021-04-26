//
//  SynthesizedSoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import Foundation
import AudioKit

class SynthesizedSoundSource: SoundSource {
    static func < (lhs: SynthesizedSoundSource, rhs: SynthesizedSoundSource) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func == (lhs: SynthesizedSoundSource, rhs: SynthesizedSoundSource) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        return id.hash(into: &hasher)
    }

    var id: Int
    var name: String
    var image: String
    var category: String
    
    @Published var volume: Float = 0
    
    var oscillators: [Oscillator] = []
    var internalMixer: Mixer
    var leftMixer: Mixer
    var rightMixer: Mixer
    
    init(id: Int, name: String, image: String, category: String = "") {
        self.id = id
        self.name = name
        self.image = image
        self.category = category
        
        self.internalMixer = Mixer()
        self.leftMixer = Mixer()
        self.rightMixer = Mixer()
        
        self.internalMixer.addInput(self.leftMixer)
        self.leftMixer.pan = -1
        
        self.internalMixer.addInput(self.rightMixer)
        self.rightMixer.pan = 1
    }
    
    func addOscillator(osc: Oscillator, pan: Float = 0.5) {
        if pan <= 0.5 {
            leftMixer.addInput(osc)
        }
        if pan >= 0.5 {
            rightMixer.addInput(osc)
        }
        osc.play()
        oscillators.append(osc)
    }
    
    func attachTo(mixer: Mixer) {
        mixer.addInput(internalMixer)
        internalMixer.volume = volume
    }
    
    func setVolume(vol: Float) {
        if internalMixer.volume != vol {
            volume = vol
            internalMixer.volume = volume
        }
    }
    
    func getVolume() -> Float {
        return volume
    }
    
    func play() {
        oscillators.forEach { osc in
            osc.play()
        }
    }
    
    func stop() {
        oscillators.forEach { osc in
            osc.stop()
        }
    }
}
