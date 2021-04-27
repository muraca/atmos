//
//  UserView.swift
//  atmos
//
//  Created by Matteo Muraca on 22/04/2021.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var shared: SharedData
    
    @State private var isShowingUsernameTextFieldAlert: Bool = false
    @State private var isShowingNewPresetTextFieldAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello, \(shared.username)!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Divider()
            
            HStack {
                Button("Change username", action: {
                    withAnimation {
                        self.isShowingUsernameTextFieldAlert.toggle()
                    }
                })
                Spacer()
            }
            
            Divider()
            
            Text("My presets")
                .font(.title)
                .multilineTextAlignment(.center)
            
            HStack {
                Button("Save current preset", action: {
                    withAnimation {
                        self.isShowingNewPresetTextFieldAlert.toggle()
                    }
                })
                Spacer()
            }
            
            List {
                ForEach (shared.presets, id: \.self.name) { preset in
                    Button(preset.name, action: {
                        shared.loadPreset(p: preset)
                    })
                }
                .onDelete(perform: removePreset)
            }
            Spacer()
        }
        .font(.title2)
        .padding()
        .alert(isPresented: $isShowingUsernameTextFieldAlert, TextAlert(title: "New username", action: {
            shared.saveUsername(username: $0!)
         }))
        .alert(isPresented: $isShowingNewPresetTextFieldAlert, TextAlert(title: "Preset name", action: {
            shared.savePreset(preset: $0!)
         }))
        
    }
    
    func removePreset(at offsets: IndexSet) {
        shared.presets.remove(atOffsets: offsets)
        shared.savePresetsInMemory()
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
//        let s = SharedData()
        UserView(shared: SharedData())
    }
}
