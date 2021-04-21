//
//  Player.swift
//  atmos
//
//  Created by Matteo Muraca on 20/04/2021.
//

import Foundation
import AudioKit

class Player: ObservableObject {
    var shared: SharedData
    var activeSources: [SampledSoundSource] = []
    var inactiveSources: [SampledSoundSource] = []
    var category: String = ""
    
    public init(shared: SharedData, activeSourcesIDs: [Int] = [], activeSourcesVolumes: [Float] = []) {
        self.shared = shared
        
        activeSourcesIDs.forEach { sourceID in
            addSource(sourceID: sourceID)
        }
        
        for i in 0..<activeSources.count {
            if (activeSourcesVolumes.count > i) {
                activeSources[i].setVolume(vol: activeSourcesVolumes[i])
            }
            else {
                break;
            }
        }
        
        shared.soundSources.forEach { source in
            if activeSourcesIDs.doesNotContain(source.id) {
                inactiveSources.append(source)
            }
        }
    }
    
    public init(shared: SharedData, category: String) {
        self.shared = shared
        
        self.category = category
        
        shared.soundSources.forEach { source in
            if source.category == category {
                activeSources.append(source)
            }
            else {
                inactiveSources.append(source)
            }
        }
    }
    
    func addSource(sourceID: Int) {
        activeSources.forEach { source in
            if (source.id == sourceID) {
                return
            }
        }
        self.activeSources.append(shared.soundSources[sourceID])
        self.activeSources.last?.setVolume(vol: 0)
        self.inactiveSources.removeAll(where: { $0.id == sourceID })
        objectWillChange.send()
    }
    
    func removeSource(sourceID: Int) {
        activeSources.forEach { source in
            if (source.id == sourceID) {
                source.stop()
                inactiveSources.append(source)
                inactiveSources.sort(by: <)
            }
        }
        activeSources.removeAll(where: { $0.id == sourceID })
        objectWillChange.send()
    }
}
