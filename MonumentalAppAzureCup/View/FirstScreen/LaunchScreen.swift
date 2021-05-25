//
//  LaunchScreen.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 22.05.2021.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var launch = false
    
    @EnvironmentObject var vm: ChatBotModel
    @AppStorage("FirstTime") var firstTime: Bool = true
    
    @State private var showingGuide = false
    var body: some View {
        ZStack{
            Chatbot()
            Color.firstBG.ignoresSafeArea()
                .opacity(launch ? 0 : 1)
                .animation(.easeInOut.delay(1.7))
            
            VStack{
                if vm.selectedImage == nil {
                    Color.firstBG.ignoresSafeArea()
                        .frame(height: 50)
                        .offset(x: launch ? 0 : -UIScreen.main.bounds.width)
                        .opacity(!launch ? 0 : 1)
                        .animation(.easeInOut)
                }
                Spacer()
            }
            if showingGuide {
                WelcomeView(firstTime: $firstTime, dismiss: $showingGuide)
            }
            
            if vm.selectedImage == nil {
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
            }
            
        }.onAppear(perform: showWelcomeGuide)
        
    }
    
    func showWelcomeGuide() {

        withAnimation(Animation.easeInOut(duration: 1.3).delay(0.6)) {
            launch.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.7){
            //testing
            showingGuide.toggle()
            
            //production
            //showingGuide = firstTime
            
            if showingGuide == false {
                withAnimation{
                    vm.chatbotTyping = true
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.2) {
                        vm.messages.append(Message(who: .bot, message: "Hello. What can I help you with?"))
                        vm.chatbotTyping = false
                    }
                }
            }
            
        }

    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
