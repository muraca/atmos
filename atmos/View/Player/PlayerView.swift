//
//  PlayerView.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct PlayerView: View {
    @EnvironmentObject var shared: SharedData
    
    var body: some View {
        ScrollView (.horizontal) {
            HStack {
                ForEach(shared.soundSources) { source in
                    PlayerComponent(soundSource: source, mixer: shared.mixer)
                }
            }
            .padding()
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
