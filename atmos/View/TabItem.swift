//
//  TabItem.swift
//  atmos
//
//  Created by Matteo Muraca on 26/04/2021.
//

import SwiftUI

struct TabItem: View {
    var icon: String = "xmark"
    var color: Color = .black
    var title: String = "Title"
    
    var body: some View {
        Image(systemName: icon)
            .foregroundColor(color)
        Text(title)
            .font(.subheadline)
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem()
    }
}
