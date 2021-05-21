//
//  CustomButtonStyle.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI


struct MySideBarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 60, height: 60)
            .padding(5)
            .background(Color.firstBG)
            .clipShape(Circle())
            .overlay(Circle()
                        .stroke(Color.azure, lineWidth: 1  ))
            .scaleEffect(!configuration.isPressed ? 1 : 0.8)
            .transition(.move(edge: .leading))
    }
}
