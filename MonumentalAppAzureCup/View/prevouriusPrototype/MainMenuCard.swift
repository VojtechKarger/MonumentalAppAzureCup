//
//  MainMenuCard.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 09.05.2021.
//

import SwiftUI

struct MainMenuCard: View {
    var imageName: String
    var text: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.init(white: 0.85), lineWidth: 2))
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            VStack {
                Spacer()
                Text(text)
                    .font(.headline.bold())
                    .padding(.bottom, 8)
            }
        }.padding()
    
    }
}

struct MainMenuCard_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuCard(imageName: "Robot", text: "Robot")
            .previewDevice("iPhone 12 Pro Max")
            .frame(width: 300, height: 300, alignment: .center)
    }
}
