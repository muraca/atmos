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
    
    public init(shared: SharedData, activeSourcesIDs: [Int] = [0,1], activeSourcesVolumes: [Float] = [0.9,0.25]) {
        self.shared = shared
        
        activeSourcesIDs.forEach { sourceID in
            addSource(sourceID: sourceID)
        }
        
        for i in 0...activeSources.count-1 {
            activeSources[i].setVolume(vol: activeSourcesVolumes[i])
        }
        
        shared.soundSources.forEach { source in
            if activeSourcesIDs.doesNotContain(source.id) {
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
        self.inactiveSources.removeAll(where: { $0.id == sourceID })
        objectWillChange.send()
    }
    
    func removeSource(sourceID: Int) {
        activeSources.forEach { source in
            if (source.id == sourceID) {
                source.stop()
                inactiveSources.append(source)
            }
        }
        activeSources.removeAll(where: { $0.id == sourceID })
        objectWillChange.send()
    }
}
