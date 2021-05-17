//
//  CustomColors.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 09.05.2021.
//

import SwiftUI

extension Color {
    static let azure = Color("Gradient1")
//        Color.init(red: 0, green: 1, blue: 240 / 255, opacity: 1)
    
    static let ghostWhite = Color("Color")
//        Color.init(red: 235 / 255, green: 235 / 255, blue: 240 / 255)
    
    static let firstBG = Color("firstBG")
    
    static let azure2 = Color("Gradient2")
}


struct GradientView: View {
    var who: Who
    var body: some View {
        switch who {
            case .bot:
                Color.ghostWhite
            default:
                LinearGradient(gradient: Gradient(colors: [Color("Gradient1"), Color("Gradient2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        
    }
}





