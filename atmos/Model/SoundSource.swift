//
//  SoundSource.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import Foundation
import AudioKit

protocol SoundSource {
    var name: String {get}
    
    func setVolume(vol: Float)
    
    func getSource() -> Node?
    
    func play()
    func stop()
}
