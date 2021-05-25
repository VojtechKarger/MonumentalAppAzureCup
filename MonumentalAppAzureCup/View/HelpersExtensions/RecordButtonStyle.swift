//
//  RecordButtonStyle.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 25.05.2021.
//

import SwiftUI


struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.azure.opacity(0.6) : Color.azure)
            .clipShape(Circle())
            .padding(3)
            .animation(.easeInOut)
            .overlay(
                Circle()
                    .strokeBorder(Color.azure ,lineWidth: 1)
            )
    }
}
