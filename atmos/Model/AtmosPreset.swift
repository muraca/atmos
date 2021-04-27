//
//  AtmosPreset.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import Foundation

class SourceInfo: NSObject, NSCoding {
    var category: String
    var id: Int
    var volume: Float
    
    init(category: String, id: Int, volume: Float) {
        self.category = category
        self.id = id
        self.volume = volume
    }
    
    required init?(coder: NSCoder) {
        self.category = coder.decodeObject(forKey: "category") as? String ?? ""
        self.id = coder.decodeInteger(forKey: "id")
        self.volume = coder.decodeFloat(forKey: "volume")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(category, forKey: "category")
        coder.encode(id, forKey: "id")
        coder.encode(volume, forKey: "volume")
    }
}

class AtmosPreset: NSObject, NSCoding {
    var name: String = ""
    
    var sampledSourcesInfo: [SourceInfo] = []
    var synthesizedSourcesInfo: [SourceInfo] = []
    var noiseSourcesInfo: [SourceInfo] = []
    
    init(name: String) {
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        sampledSourcesInfo = coder.decodeObject(forKey: "sampledSourcesInfo") as? [SourceInfo] ?? []
        synthesizedSourcesInfo = coder.decodeObject(forKey: "synthesizedSourcesInfo") as? [SourceInfo] ?? []
        noiseSourcesInfo = coder.decodeObject(forKey: "noiseSourcesInfo") as? [SourceInfo] ?? []
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(sampledSourcesInfo, forKey: "sampledSourcesInfo")
        coder.encode(synthesizedSourcesInfo, forKey: "synthesizedSourcesInfo")
        coder.encode(noiseSourcesInfo, forKey: "noiseSourcesInfo")
    }
}
