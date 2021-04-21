//
//  SampledSoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import Foundation
import AudioKit
import AVFoundation

class SampledSoundSource: Hashable, Identifiable {
    static func == (lhs: SampledSoundSource, rhs: SampledSoundSource) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        return id.hash(into: &hasher)
    }

    var id: Int
    var name: String
    var image: String
    var soundFile: String
    
    var audioPlayer: AudioPlayer?
    
    init(id: Int, name: String, image: String, soundFile: String) {
        self.id = id
        self.name = name
        self.image = image
        self.soundFile = soundFile
        
        guard let url = Bundle.main.url(forResource: soundFile, withExtension: nil) else {return}
        do {
            let audioFile = try AVAudioFile(forReading: url)
            audioPlayer = AudioPlayer(file: audioFile, buffered: true)
            audioPlayer?.isLooping = true
            audioPlayer?.volume = 0
            print("\(name) loaded")
        } catch {
            Log("Could not load: \(soundFile)")
        }
    }
    
    func attachTo(mixer: Mixer) {
        mixer.addInput(audioPlayer!)
    }
    
    func setVolume(vol: Float)  {
        audioPlayer?.volume = vol
    }
    
    func getVolume() -> Float {
        return audioPlayer?.volume ?? 0
    }
    
    func play() {
        audioPlayer?.play()
        print("\(name) playing")
    }
    
    func stop() {
        audioPlayer?.stop()
        print("\(name) stopped")
        
    }
}

