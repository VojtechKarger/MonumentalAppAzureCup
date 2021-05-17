//
//  CustomTextField.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 10.05.2021.
//

import SwiftUI


extension TextField {
    
    func underlineText(color: Color) -> some View {
        self.modifier(UnderLinedText(color: color))
    }
}

struct UnderLinedText: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {

            content
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color ,lineWidth: 1)
                )

        
    }
}

