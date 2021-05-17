//
//  Obrazek.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 09.05.2021.
//

import SwiftUI

struct Obrazek: View {
    var geo: GeometryProxy
    var imageName: String

    
    var body: some View {
        ZStack(alignment: .top) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: -geo.size.width / 1.5)
                .frame(width: geo.size.width, height: geo.size.height / 9 * 8, alignment: .leading)
            Rectangle()
                .fill(Color.azure.opacity(0.5))
                .blendMode(.normal)
                .ignoresSafeArea()
            Rectangle()
                .fill(Color.white)
                .rotationEffect(Angle(degrees: 45))
                .frame(width: geo.size.width * 2, height: geo.size.height * 2)
                .offset(x: geo.size.width , y: geo.size.height / 4)
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}

struct Obrazek_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
