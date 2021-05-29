//
//  MessageView.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var vm: ChatBotModel

    var message: Message
    var scroll: ScrollViewProxy
    
    @AppStorage("image") var image: Data = UIImage(named: "user")!.pngData()!
    
    
    
    var body: some View {
        HStack{
            if message.who == .user{
                Spacer()
            }else{
                VStack {
                    if message.image != nil {
                        Spacer()
                    }
                    Image("Bot")
                        .profilePicture(who: .bot)
                }
            }
            if let image = message.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .id(message.id)
                    .onAppear(perform: { vm.scroll(scroll: scroll)} )
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
                        .foregroundColor(.azure)
                        .underline()
                }
                .id(message.id)
                .onAppear(perform: {
                    if vm.messages.count > 1{
                        scroll.scrollTo(vm.messages[vm.messages.count - 1].id)
                    }
                })

            }
            
            if let mess = message.message {
                ZStack(alignment: .leading) {
                    Text(mess)
                        .lineLimit(nil)
                        .padding(13)
                        .foregroundColor((message.who == .user) ? .white : .primary)
                        .background(GradientView(who: message.who))
                        .clipShape(RoundedRectangle(cornerRadius: 22.0))
                        .padding(.trailing,(message.who == .bot) ? 60:0)
                        .padding(.leading ,(message.who == .user) ? 60:0)
                        .id(message.id)
                        .onAppear(perform: { vm.scroll(scroll: scroll) })
                        .onTapGesture{
                            vm.speak(messafe: message.message!)
                        }
                    
                }
            }
            
            if message.who == .bot {
                Spacer()
            } else {
                VStack {
                    if message.image != nil {
                        Spacer()
                            
                    }
                    let img = UIImage(data: image)!
                    
                    Image(uiImage: img)
                        .profilePicture(who: .user)
                }
            }
            
            
        }.padding([.top,.bottom], (message.image != nil) ? 10 : 0)
    }
}


struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        Chatbot()
            .previewDevice("iPhone 12 Pro Max")
            .environmentObject(ChatBotModel())

    }
}
