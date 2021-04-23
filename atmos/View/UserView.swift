//
//  UserView.swift
//  atmos
//
//  Created by Matteo Muraca on 22/04/2021.
//

import SwiftUI

struct UserView: View {
    var shared: SharedData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Placeholder")
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(shared: SharedData())
    }
}
