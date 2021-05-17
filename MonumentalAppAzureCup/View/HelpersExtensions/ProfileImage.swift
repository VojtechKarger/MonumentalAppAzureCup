//
//  ProfileImage.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 17.05.2021.
//

import SwiftUI



extension Image {
    
    func profilePicture(who: Who) -> some View{
        self
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50, alignment: .center)
            .background(GradientView(who: who))
            .clipShape(Circle())
        
    }
}
