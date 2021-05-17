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
                        ZStack {
                            Color.firstBG
                            ScrollView {
                                ScrollViewReader { scroll in
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(height: 50, alignment: .center)
                                        
                                    ForEach(vm.messages){ message in
                                        MessageView(vm: vm, message: message, scroll: scroll)
                                    }
                                    if vm.buttonText != "" {
                                        Button(action: {
                                            vm.yesPlease()
                                        }, label: {
                                            Text(vm.buttonText ?? "Yes please!")
                                        })
                                    }
                                }
                            }
                            VStack{
                                HStack{
                                    Image("Robot")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .padding(5)
                                        .background(Color.ghostWhite)
                                        .clipShape(Circle())
                                    Spacer()
                                    Button(action: {}, label: {
                                        Image(systemName: "info.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25, alignment: .center)
                                            
                                    }).padding(.horizontal)
                                }
                                .padding(.top,8)
                                .background(Color.firstBG.opacity(0.5))
                                .ignoresSafeArea()
                                Spacer()
                            }
                        }
                        .blur(radius: textfieldIsActive ? 0 : 4)
                        .onTapGesture {
                            withAnimation{
                                hideKeyboard()
                                vm.hide()
                            }
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                withAnimation{
                                    textfieldIsActive = true
                                }
                            }
                    }
                        
                        
                        
                        CustomTextField(vm: vm, textfieldIsActive: $textfieldIsActive)
                    }.offset(y: !vm.showingRecordingScreen ? 0 : -200)
                    
                    SpeechToTextView()
                        .frame(width: UIScreen.main.bounds.width ,height: 200)
                        .background(Color.white)
                        .offset(y: vm.showingRecordingScreen ? 0 : 800)
                        .sheet(isPresented: $vm.showing){
                            if vm.takeingPhoto == true{
                                ImagePicker(vm: vm, type: .camera).onAppear(perform: {
                                    vm.loading = false
                                })
                            }else {
                                ImagePicker(vm: vm, type: .photoLibrary)
                            }
                        }
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



