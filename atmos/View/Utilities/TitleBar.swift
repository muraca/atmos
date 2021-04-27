//
//  TitleBar.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import SwiftUI

struct TitleBar: View {
    @EnvironmentObject var shared: SharedData
    var text: String = "Title"
    var color: Color = .primary
    
    var body: some View {
        HStack {
            Text(text)
                .font(.title)
                .bold()
                .foregroundColor(color)
            
            Spacer()
            
            Button(action: {
                shared.mute()
            }, label: {
                Image(systemName: "speaker.slash.fill")
                    .font(.title)
                    .foregroundColor(color)
            })
        }
        .padding()
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
            .environmentObject(SharedData())
    }
}
