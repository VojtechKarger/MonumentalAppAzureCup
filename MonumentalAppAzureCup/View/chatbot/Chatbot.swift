//
//  Chatbot.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 09.05.2021.
//

import SwiftUI

struct Chatbot: View {
    @EnvironmentObject var vm: ChatBotModel
    @State private var textfieldIsActive = true

    @ObservedObject var am: MicrophoneMonitor
    
    
    var body: some View {
        LoadingView(isShowing: $vm.loading){
            GeometryReader{ geo in
                ZStack(alignment: .bottom){
                    VStack {
                        ListOfMessages(textfieldIsActive: $textfieldIsActive)

                        CustomTextField(vm: vm, textfieldIsActive: $textfieldIsActive)
                    }.offset(y: !vm.showingRecordingScreen ? 0 : -200)
                    
                    SpeechToTextView()
                        
                    if let img = vm.selectedImage {
                        ZStack {
                            Color.ghostWhite.opacity(0.9)
                                .ignoresSafeArea()
                            img
                                .resizable()
                                .scaledToFit()
                                .gesture(
                                    DragGesture()
                                        .onEnded({ _ in
                                            withAnimation{
                                                vm.selectedImage = nil
                                            }
                                        })
                                )
                                .onTapGesture {
                                    withAnimation{
                                        vm.selectedImage = nil
                                    }
                            }
                        }.transition(.opacity)
                    }
                    
                    
                }
            }
        }.environmentObject(am)
    }
    
}

struct Chatbot_Previews: PreviewProvider {
    static var previews: some View {
        Chatbot(am: MicrophoneMonitor(numberOfSamples: 3))
            .previewDevice("iPhone 12 Pro Max")
            .environmentObject(ChatBotModel())
    }
}




