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
            Text(NSLocalizedString("Hello", comment: "") + ", \(shared.username)!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Divider()
            
            HStack {
                Button(NSLocalizedString("Change username", comment: ""), action: {
                    withAnimation {
                        self.isShowingUsernameTextFieldAlert.toggle()
                    }
                })
                Spacer()
            }
            
            Divider()
            
            Text(NSLocalizedString("My presets", comment: ""))
                .font(.title)
                .multilineTextAlignment(.center)
            
            HStack {
                Button(NSLocalizedString("Save current preset", comment: ""), action: {
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
        .alert(isPresented: $isShowingUsernameTextFieldAlert,
               TextAlert(title: NSLocalizedString("New username", comment: ""), action: {
                    shared.saveUsername(username: $0!)
               }))
        .alert(isPresented: $isShowingNewPresetTextFieldAlert,
               TextAlert(title: NSLocalizedString("Preset name", comment: ""), action: {
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
        UserView(shared: SharedData())
    }
}
