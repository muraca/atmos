//
//  SoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 23/04/2021.
//

import Foundation
import AudioKit
import SwiftUI

protocol SoundSource: Hashable, Identifiable, Comparable, ObservableObject {
    var id: Int {get}
    var name: String {get}
    var image: String {get}
    var category: String {get}
    
    var volume: Float {get set}
    
    func attachTo(mixer: Mixer)
    
    func setVolume(vol: Float)
    func getVolume() -> Float
    
    func play()
    func stop()
}
