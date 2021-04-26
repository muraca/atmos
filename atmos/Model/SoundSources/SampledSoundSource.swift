//
//  SampledSoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import Foundation
import AudioKit
import AVFoundation

class SampledSoundSource: SoundSource {
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
    var category: String
    var soundFile: String
    
    @Published var volume: Float = 0
    
    var audioPlayer: AudioPlayer?
    
    init(id: Int, name: String, image: String, soundFile: String, category: String = "") {
        self.id = id
        self.name = name
        self.image = image
        self.category = category
        self.soundFile = soundFile
        
        guard let url = Bundle.main.url(forResource: soundFile, withExtension: nil) else {return}
        do {
            let audioFile = try AVAudioFile(forReading: url)
            audioPlayer = AudioPlayer(file: audioFile, buffered: true)
            audioPlayer?.isLooping = true
            audioPlayer?.volume = volume
        } catch {
            Log("Could not load: \(soundFile)")
        }
    }
    
    func attachTo(mixer: Mixer) {
        mixer.addInput(audioPlayer!)
    }
    
    func setVolume(vol: Float)  {
        if audioPlayer?.volume != vol {
            volume = vol
            audioPlayer?.volume = vol
        }
    }
    
    func getVolume() -> Float {
        return volume
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}

