//
//  SharedData.swift
//  atmos
//
//  Created by Matteo Muraca on 19/04/2021.
//

import Foundation
import Combine
import AudioKit

final class SharedData: ObservableObject {
//    @Published var persistenceController = PersistenceController.shared
    
    @Published var username: String = "user"
    
    var sampledSoundSources: [String: [SampledSoundSource]]
    var synthesizedSoundSources: [String: [SynthesizedSoundSource]]
    
    var engine: AudioEngine
    var mixer: Mixer
    
    init() {
        engine = AudioEngine()
        mixer = Mixer()
        sampledSoundSources = loadSampledSoundSources()
        synthesizedSoundSources = loadSynthesizedSoundSources()
        
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
