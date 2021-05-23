//
//  LaunchScreen.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 22.05.2021.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var launch = false
    
    @AppStorage("FirstTime") var firstTime: Bool = true
    
    @State private var showingGuide = false
    var body: some View {
        ZStack{
            Chatbot()
            let someAnimation = Animation.linear(duration: 1).delay(3)
            (launch ? Color.clear.ignoresSafeArea() : Color.firstBG.ignoresSafeArea())
            VStack{
                Color.firstBG.ignoresSafeArea()
                    .frame(height: 50)
                    .offset(x: launch ? 0 : -UIScreen.main.bounds.width)
                    .opacity(!launch ? 0 : 1)
                    .animation(someAnimation)
                Spacer()
            }
            
            VStack{
                HStack {
                    LOGO()
                        .scaleEffect(launch ? 0.66 : 1)
                        .frame(height: 50)
                        .offset(x: !launch ? 0 : -UIScreen.main.bounds.width / 6)
                        
                    if launch {
                        Spacer()
                    }
                }
                if launch {
                    Spacer()
                }
            }
            
            if showingGuide {
                WelcomeView(dismiss: $showingGuide)
            }
            
            
        }.onAppear(perform: {
            
            //Just for testing delete than...
            firstTime = true
            
            showingGuide = firstTime
            
            withAnimation(Animation.easeInOut(duration: 3).delay(1)) {
                launch.toggle()

            }
        })
        
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
