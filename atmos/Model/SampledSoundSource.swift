//
//  SampledSoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import Foundation
import AudioKit
import AVFoundation

class SampledSoundSource: Hashable, Identifiable, Comparable {
    static func < (lhs: SampledSoundSource, rhs: SampledSoundSource) -> Bool {
        return lhs.id < rhs.id
    }
    
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
    var category: String
    
    var audioPlayer: AudioPlayer?
    
    init(id: Int, name: String, image: String, soundFile: String, category: String = "") {
        self.id = id
        self.name = name
        self.image = image
        self.soundFile = soundFile
        self.category = category
        
        guard let url = Bundle.main.url(forResource: soundFile, withExtension: nil) else {return}
        do {
            let audioFile = try AVAudioFile(forReading: url)
            audioPlayer = AudioPlayer(file: audioFile, buffered: true)
            audioPlayer?.isLooping = true
            audioPlayer?.volume = 0
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
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}

