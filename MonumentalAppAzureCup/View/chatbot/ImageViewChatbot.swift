//
//  ImageViewChatbot.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 17.05.2021.
//

import SwiftUI

struct ImageViewChatbot: View {
    @EnvironmentObject var vm: ChatBotModel

    var img: Image
    
    var body: some View {
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

struct ImageViewChatbot_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewChatbot(img: Image("bgImage3"))
            .environmentObject(ChatBotModel())
    }
}
