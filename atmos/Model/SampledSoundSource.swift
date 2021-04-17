//
//  SampledSoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import Foundation
import AudioKit
import AVFoundation

struct SampledSoundSource: SoundSource {
    var name: String
    
    var soundSource: AudioPlayer?
    
    init(fileName: String) {
        name = String(fileName.dropLast(4))

        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {return}
        
        do {
            let audioFile = try AVAudioFile(forReading: url)
            soundSource = AudioPlayer(file: audioFile)
            soundSource?.isLooping = true
            soundSource?.volume = 0
            print("\(name) volume zero")
            
        } catch {
            Log("Could not load: $fileName")
        }
    }
    
    func setVolume(vol: Float) {
        print("\(name) wanna set vol: \(vol) ")
        soundSource?.volume = vol
        print("\(name) vol: \(String(describing: soundSource?.volume)) ")
    }
    
    func getSource() -> Node? {
        return soundSource
    }
    
    func play() {
        soundSource?.play()
        print("\(name) playing")
    }
    
    func stop() {
        soundSource?.stop()
        print("\(name) stopped")
        
    }
}
