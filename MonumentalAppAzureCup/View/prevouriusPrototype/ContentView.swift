//
//  ContentView.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 07.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var horizontal = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationView{
                ZStack{
                    Obrazek(geo: geo, imageName: "bgImage4")
                    VStack{
                        Spacer()
                        Text("Vítejte v památkovači")
                            .font(.largeTitle.bold())
                            .padding(.bottom)
                        
                        LazyVGrid(columns:[ GridItem(.flexible())
                                            ,GridItem(.flexible())
                        ]){
                            NavigationLink(destination: CameraView(model: ChatBotModel())) {
                                MainMenuCard(imageName: "Camera", text: "Camera")
                            }.buttonStyle(PlainButtonStyle())
                            MainMenuCard(imageName: "Gallery", text: "Gallery")
//                            MainMenuCard(imageName: "Robot", text: "Pruvodce")
//                            MainMenuCard(imageName: "Settings", text: "Settings")
                        }
                        .frame(width: UIScreen.main.bounds.width / 1.1)
                        Spacer()
                        
                    }
     
                }.navigationBarHidden(true)
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}


