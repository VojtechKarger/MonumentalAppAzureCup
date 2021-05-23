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
            Color.firstBG.ignoresSafeArea()
                .opacity(launch ? 0 : 1)
                .animation(.easeInOut.delay(4))
            
            VStack{
                Color.firstBG.ignoresSafeArea()
                    .frame(height: 50)
                    .offset(x: launch ? 0 : -UIScreen.main.bounds.width)
                    .opacity(!launch ? 0 : 1)
                    .animation(.easeInOut)
                Spacer()
            }
            if showingGuide {
                WelcomeView(firstTime: $firstTime, dismiss: $showingGuide)
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
            
            
            
            
        }.onAppear(perform: {
            
            //Just for testing delete than...
//            firstTime = true

            withAnimation(Animation.easeInOut(duration: 3).delay(1)) {
                launch.toggle()

            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4){
                //testing
                showingGuide.toggle()
                
                //production
                //showingGuide = firstTime
            }
        })
        
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
