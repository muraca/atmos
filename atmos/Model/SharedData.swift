//
//  SharedData.swift
//  atmos
//
//  Created by Matteo Muraca on 19/04/2021.
//

import Foundation
import Combine
import AudioKit
import SwiftUI

final class SharedData: ObservableObject {
    @Published var username: String = UserDefaults.standard.string(forKey: "username") ?? "user"
    
    var sampledSoundSources: [String: [SampledSoundSource]] = [:]
    var synthesizedSoundSources: [String: [SynthesizedSoundSource]] = [:]
    var noiseSoundSources: [NoiseSoundSource] = []
    
    @Published var presets: [AtmosPreset] = []
    
    var engine: AudioEngine
    var mixer: Mixer
    
    init() {
        engine = AudioEngine()
        mixer = Mixer()
        sampledSoundSources = loadSampledSoundSources()
        synthesizedSoundSources = loadSynthesizedSoundSources()
        noiseSoundSources = loadNoiseSoundSources()
        
        engine.output = mixer
        
        do {
            try engine.start()
            print("engine started")
        }
        catch {
            fatalError("can't start engine")
        }
        
        for (_, sources) in sampledSoundSources {
            for source in sources {
                source.attachTo(mixer: mixer)
            }
        }
        
        for (_, sources) in synthesizedSoundSources {
            for source in sources {
                source.attachTo(mixer: mixer)
            }
        }
        
        for source in noiseSoundSources {
            source.attachTo(mixer: mixer)
        }
        
        loadPresetsFromMemory()
    }
    
    func mute() {
        for (_, sources) in sampledSoundSources {
            for source in sources {
                source.setVolume(vol: 0)
            }
        }
        
        for (_, sources) in synthesizedSoundSources {
            for source in sources {
                source.setVolume(vol: 0)
            }
        }
        
        for source in noiseSoundSources {
            source.setVolume(vol: 0)
        }
    }
    
    func play() {
        for (_, sources) in sampledSoundSources {
            for source in sources {
                source.play()
            }
        }
        
        for (_, sources) in synthesizedSoundSources {
            for source in sources {
                source.play()
            }
        }
        
        for source in noiseSoundSources {
            source.play()
        }
    }
    
    func stop() {
        for (_, sources) in sampledSoundSources {
            for source in sources {
                source.stop()
            }
        }
        
        for (_, sources) in synthesizedSoundSources {
            for source in sources {
                source.stop()
            }
        }
        
        for source in noiseSoundSources {
            source.stop()
        }
    }
    
    func loadPreset(p: AtmosPreset) {
        mute()
        
        for info in p.sampledSourcesInfo {
            for source in sampledSoundSources[info.category]! {
                if source.id == info.id {
                    source.setVolume(vol: info.volume)
                    break
                }
            }
        }
        
        for info in p.synthesizedSourcesInfo {
            for source in synthesizedSoundSources[info.category]! {
                if source.id == info.id {
                    source.setVolume(vol: info.volume)
                    break
                }
            }
        }
        
        for info in p.noiseSourcesInfo {
            for source in noiseSoundSources {
                if source.id == info.id {
                    source.setVolume(vol: info.volume)
                    break
                }
            }
        }
    }
    
    func saveUsername(username: String) {
        self.username = username
        UserDefaults.standard.set(username, forKey: "username")
    }
    
    func savePreset(preset: String) {
        let p = AtmosPreset(name: preset)
        
        for (_, sources) in sampledSoundSources {
            for source in sources {
                if source.volume > 0 {
                    p.sampledSourcesInfo.append(SourceInfo(category: source.category, id: source.id, volume: source.volume))
                }
            }
        }
        
        for (_, sources) in synthesizedSoundSources {
            for source in sources {
                if source.volume > 0 {
                    p.synthesizedSourcesInfo.append(SourceInfo(category: source.category, id: source.id, volume: source.volume))
                }
            }
        }
        
        for source in noiseSoundSources {
            if source.volume > 0 {
                p.noiseSourcesInfo.append(SourceInfo(category: source.category, id: source.id, volume: source.volume))
            }
        }
        
        presets.append(p)
        
        savePresetsInMemory()
    }

    func savePresetsInMemory() {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: presets, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "presets")
        } catch {
            Log("Unable to save presets in memory")
        }
    }
    
    func loadPresetsFromMemory() {
        do {
            let decoded = UserDefaults.standard.object(forKey: "presets") as! Data?
            if decoded != nil {
                presets = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as! [AtmosPreset]
            }
        } catch {
            Log("Unable to load presets from memory")
            presets = []
        }
    }
}

func loadSampledSoundSources() -> [String: [SampledSoundSource]] {
    let data: Data
    guard let file = Bundle.main.url(forResource: "SampledSoundSources.json", withExtension: nil)
    else {
        fatalError("Couldn't find SampledSoundSources.json in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load SampledSoundSources.json from main bundle:\n\(error)")
    }
    
    var jsonData: [[String:Any]] = []
    
    do {
        jsonData = try (JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]])!
        
        var map: [String: [SampledSoundSource]] = [:]
        var count = 0
        jsonData.forEach { jsonObj in
            let new = SampledSoundSource(id: count,
                                         name: jsonObj["name"] as! String,
                                         image: jsonObj["image"] as! String,
                                         soundFile: jsonObj["soundFile"] as! String,
                                         category: jsonObj["category"] as! String)
            
            if map[jsonObj["category"] as! String] == nil {
                map[jsonObj["category"] as! String] = []
            }
            
            map[jsonObj["category"] as! String]?.append(new)
            
            count += 1
        }
        
        return map
    } catch {
        fatalError("Couldn't parse SampleSoundSources.json\n\(error)")
    }
}

func loadSynthesizedSoundSources() -> [String: [SynthesizedSoundSource]] {
    let data: Data
    guard let file = Bundle.main.url(forResource: "SynthesizedSoundSources.json", withExtension: nil)
    else {
        fatalError("Couldn't find SynthesizedSoundSources.json in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load SynthesizedSoundSources.json from main bundle:\n\(error)")
    }
    
    var jsonData: [[String:Any]] = []
    
    do {
        jsonData = try (JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]])!
        
        var map: [String: [SynthesizedSoundSource]] = [:]
        var count = 0
        jsonData.forEach { jsonObj in
            let new = SynthesizedSoundSource(id: count,
                                             name: jsonObj["name"] as! String,
                                             image: jsonObj["image"] as! String,
                                             category: jsonObj["category"] as! String)
            
            let oscMap = jsonObj["oscillators"] as! [[String: Any]]
            
            for osc in oscMap {
                let o = Oscillator(frequency: (osc["frequency"] as! NSNumber).floatValue,
                                   amplitude: 0.9)
                new.addOscillator(osc: o,
                                  pan: (osc["panning"] as! NSNumber).floatValue)
            }
            
            if map[jsonObj["category"] as! String] == nil {
                map[jsonObj["category"] as! String] = []
            }
            
            map[jsonObj["category"] as! String]?.append(new)
            
            count += 1
        }
        
        return map
    } catch {
        fatalError("Couldn't parse SynthesizedSoundSources.json\n\(error)")
    }
}

func loadNoiseSoundSources() -> [NoiseSoundSource] {
    return [
        NoiseSoundSource(id: 0, type: "White Noise", image: "SoundWave"),
        NoiseSoundSource(id: 1, type: "Pink Noise", image: "SoundWave"),
        NoiseSoundSource(id: 2, type: "Brown Noise", image: "SoundWave")
    ]
}


