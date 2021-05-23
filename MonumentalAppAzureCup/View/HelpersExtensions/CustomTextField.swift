//
//  CustomTextField.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 10.05.2021.
//

import SwiftUI


extension TextField {
    
    func underlineText(color: Color) -> some View {
        self.modifier(UnderLinedText(color: color)).cornerRadius(10)
    }
}

struct UnderLinedText: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .padding(.horizontal , 10)

            GradientView(who: .user)
                .mask(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color ,lineWidth: 3)
                )
                .frame(height: 50, alignment: .center)

        }

        
    }
}

