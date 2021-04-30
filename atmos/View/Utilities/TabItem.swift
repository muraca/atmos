//
//  TabItem.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import SwiftUI

struct TabItem: View {
    var icon: String = "xmark"
    var title: String = NSLocalizedString("Title", comment: "")
    
    var body: some View {
        Image(systemName: icon)
        Text(title)
            .font(.subheadline)
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem()
    }
}
