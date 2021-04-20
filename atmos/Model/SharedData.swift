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
    
    var soundSources: [SampledSoundSource]
    
    var engine: AudioEngine
    var mixer: Mixer
    
    init() {
        engine = AudioEngine()
        mixer = Mixer()
        soundSources = loadSampledSoundSources()
        
        engine.output = mixer
        
        print("\(soundSources.count) sources found")
        
        do {
            try engine.start()
            print("engine started")
        }
        catch {
            fatalError("can't start engine")
        }
        
        soundSources.forEach { source in
            source.attachTo(mixer: mixer)
        }
    }
}

func loadSampledSoundSources() -> [SampledSoundSource] {
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
        
        var arr: [SampledSoundSource] = []
        
        jsonData.forEach {
            arr.append(SampledSoundSource(id: $0["id"] as! Int,
                                          name: $0["name"] as! String,
                                          image: $0["image"] as! String,
                                          soundFile: $0["soundFile"] as! String))
        }
        
        return arr
    } catch {
        fatalError("Couldn't parse SampleSoundSources.json\n\(error)")
    }
}
