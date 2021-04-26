//
//  NoiseSoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import Foundation
import AudioKit

class NoiseSoundSource: SoundSource {
    static func < (lhs: NoiseSoundSource, rhs: NoiseSoundSource) -> Bool {
        return lhs.id < rhs.id
    }
    
    static func == (lhs: NoiseSoundSource, rhs: NoiseSoundSource) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return id.hash(into: &hasher)
    }
    
    var id: Int
    var name: String
    var image: String
    var category: String = "Noise"
    
    @Published var volume: Float = 0
    
    var generator: Node & Toggleable
    
    init(id: Int, type: String, image: String) {
        self.id = id
        self.name = type
        self.image = image
        
        switch type {
            case "White Noise":
                generator = WhiteNoise(amplitude: 0)
                break
            case "Pink Noise":
                generator = PinkNoise(amplitude: 0)
                break
            case "Brown Noise":
                generator = BrownianNoise(amplitude: 0)
                break
            default:
                fatalError("Wrong type of noise")
        }
    }
    
    func attachTo(mixer: Mixer) {
        mixer.addInput(generator)
    }
    
    func setVolume(vol: Float) {
        if let g = generator as? WhiteNoise {
            if g.amplitude != vol {
                g.amplitude = vol
                volume = vol
            }
        }
        else if let g = generator as? PinkNoise {
            if g.amplitude != vol {
                g.amplitude = vol
                volume = vol
            }
        }
        else if let g = generator as? BrownianNoise {
            if g.amplitude != vol {
                g.amplitude = vol
                volume = vol
            }
        }
    }
    
    func getVolume() -> Float {
        return volume
    }
    
    func play() {
        generator.play()
    }
    
    func stop() {
        generator.stop()
    }
}
