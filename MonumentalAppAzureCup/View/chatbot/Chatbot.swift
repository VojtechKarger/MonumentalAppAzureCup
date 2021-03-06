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
    
    var body: some View {
        LoadingView(isShowing: $vm.loading){
            ScrollViewReader { scroll in
                GeometryReader{ geo in
                    ZStack(alignment: .bottom){
                        Color.firstBG.ignoresSafeArea()
                        VStack {
                            ListOfMessages(textfieldIsActive: $textfieldIsActive, scroll: scroll)

                            CustomTextField(vm: vm, textfieldIsActive: $textfieldIsActive, scroll: scroll)
                        }.offset(y: !vm.showingRecordingScreen ? 0 : -200)
                        
                        SpeechToTextView()
                        
                        if let img = vm.selectedImage {
                            ImageViewChatbot(img: img)
                        }
                    }
                }
            }
        }
    }

}

struct Chatbot_Previews: PreviewProvider {
    static var previews: some View {
        Chatbot()
            .previewDevice("iPhone 12 Pro Max")
            .environmentObject(ChatBotModel())
    }
}






