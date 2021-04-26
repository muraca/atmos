//
//  SoundSourcesCategories.swift
//  atmos
//
//  Created by Matteo Muraca on 23/04/2021.
//

import Foundation
import SwiftUI

var sampleCategories: [String] = [
    "Water",
    "Weather",
    "Nature"
]

var singleSynthCategories: [String] = [
    "Binaural"
]

var categoryIcon: [String:String] = [
    "Water" : "drop",
    "Weather" : "cloud.sun",
    "Nature" : "leaf",
    "Binaural" : "waveform"
]

var categoryColor: [String:Color] = [
    "Water" : .blue,
    "Nature" : .green,
    "Weather" : .gray,
    "Binaural" : .purple,
    "" : .black
]
