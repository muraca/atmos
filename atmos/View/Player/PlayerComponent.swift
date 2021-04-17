//
//  PlayerComponent.swift
//  atmos
//
//  Created by Matteo Muraca on 17/04/2021.
//

import SwiftUI
import AudioKit

struct PlayerComponent: View {
    var soundSource: SoundSource
    @State private var volume: Float = 0.0
    
    var body: some View {
        VStack(alignment: .center) {
            Image(soundSource.name)
                .resizable()
                .frame(width: 70, height: 70)
                .padding(.top)
            
            Text(soundSource.name)
                .font(.title)
                .multilineTextAlignment(.center)
                .frame(width: 120, height: 100, alignment: .center)
            
            Slider(value: $volume, in: 0.0...1.0)
                .frame(width: 180, height: 50)
                .rotationEffect(.degrees(-90))
                .padding(.horizontal, -50.0)
                .padding(.top, 50.0)
                .padding(.bottom, 80.0)
                .onChange(of: volume, perform: { value in
                    soundSource.setVolume(vol: volume)
                })
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15.0)
                .stroke(lineWidth: 2.0)
        )
    }
}

struct PlayerComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlayerComponent(soundSource: SampledSoundSource(fileName: "Rain.wav"))
    }
}
