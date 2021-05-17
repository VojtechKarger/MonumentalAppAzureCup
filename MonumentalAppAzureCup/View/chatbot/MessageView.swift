//
//  MessageView.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var vm: ChatBotModel
    @EnvironmentObject var am: MicrophoneMonitor
    var message: Message
    var scroll: ScrollViewProxy
    
    var body: some View {
        HStack{
            if message.who == .user{
                Spacer()
            }else{
                VStack {
                    if message.image != nil {
                        Spacer()
                    }
                    Image("Robot")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(Color.ghostWhite)
                        .clipShape(Circle())
                }
            }
            if let image = message.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .id(message.id)
                    .onAppear(perform: {
                        if vm.messages.count > 1{
                            scroll.scrollTo(vm.messages[vm.messages.count - 1].id)
                        }
                    })
                    .onTapGesture {
                        withAnimation{
                            vm.selectedImage = image
                            hideKeyboard()
                        }
                    }
            }
            if let url = message.url {
                Link(destination: url) {
                    Text("Here!")
                }
                .id(message.id)
                .onAppear(perform: {
                    if vm.messages.count > 1{
                        scroll.scrollTo(vm.messages[vm.messages.count - 1].id)
                    }
                })

            }
            
            if let mess = message.message {
                Text(mess)
                    .foregroundColor(.primary)
                    .padding()
                    .background(GradientView(who: message.who))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .padding(.trailing,(message.who == .bot) ? 60:0)
                    .padding(.leading ,(message.who == .user) ? 60:0)
                    .id(message.id)
                    .onAppear(perform: {
                        if vm.messages.count > 1{
                            scroll.scrollTo(vm.messages[vm.messages.count - 1].id)
                        }
                    })
                    .onTapGesture{
                        vm.speak(messafe: message.message!)
                    }
                
            }
            
            if message.who == .bot {
                Spacer()
            } else {
                VStack {
                    if message.image != nil {
                        Spacer()
                            
                    }
                    Image("user")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(GradientView(who: .user))
                        .clipShape(Circle())
                }
            }
            
            
        }.padding([.top,.bottom], (message.image != nil) ? 10 : 0)
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        Chatbot(am: MicrophoneMonitor(numberOfSamples: 3))
            .previewDevice("iPhone 12 Pro Max")
            .environmentObject(ChatBotModel())

    }
}
