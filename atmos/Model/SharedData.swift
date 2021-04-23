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
    
    var username: String = "user"
    
    var sampledSoundSources: [String: [SampledSoundSource]]
    
    var engine: AudioEngine
    var mixer: Mixer
    
    init() {
        engine = AudioEngine()
        mixer = Mixer()
        sampledSoundSources = loadSampledSoundSources()
        
        engine.output = mixer
        
        print("\(sampledSoundSources.count) sources found")
        
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
    }
    
    func mute() {
        for (_, sources) in sampledSoundSources {
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
    }
    
    func stop() {
        for (_, sources) in sampledSoundSources {
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
        var count = 1
        jsonData.forEach {
            let new = SampledSoundSource(id: count,
                                         name: $0["name"] as! String,
                                         image: $0["image"] as! String,
                                         soundFile: $0["soundFile"] as! String,
                                         category: $0["category"] as! String)
            
            if map[$0["category"] as! String] == nil {
                map[$0["category"] as! String] = []
            }
            map[$0["category"] as! String]?.append(new)
            
            count += 1
        }
        
        return map
    } catch {
        fatalError("Couldn't parse SampleSoundSources.json\n\(error)")
    }
}
