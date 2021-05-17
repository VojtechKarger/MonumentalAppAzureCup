//
//  CustomTextField.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI

struct CustomTextField: View {
    @ObservedObject var vm: ChatBotModel
    @Binding var textfieldIsActive: Bool
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Button(action: { vm.takeingPhoto = false; textfieldIsActive = true ; vm.hide() ; vm.showing.toggle() ; print("aaaaaa") }) {
                        Image("Gallery")
                            .resizable()
                            .scaledToFit()
                    }
                    .animation(.easeInOut)
                    .buttonStyle(MySideBarButtonStyle())
                    .frame(width: 65, height: 65)
                    .offset(x: 10, y: -70)
                    .isHidden(textfieldIsActive, remove: true)
                    
                    
                    Button(action: openCamera) {
                        Image("Camera")
                            .resizable()
                            .scaledToFit()
                    }
                    .animation(.easeInOut.delay(0.2))
                    .buttonStyle(MySideBarButtonStyle())
                    .frame(width: 65, height: 65)
                    .offset(x: 10, y: -150)
                    .isHidden(textfieldIsActive, remove: true)
                    
                    
                    Button(action: { vm.hideRecordingScreen(); textfieldIsActive = true; hideKeyboard() }) {
                        Image("Mic")
                            .resizable()
                            .scaledToFit()
                    }
                    .animation(.easeInOut.delay(0.5))
                    .buttonStyle(MySideBarButtonStyle())
                    .frame(width: 65, height: 65)
                    .offset(x: 10, y: -230)
                    .isHidden(textfieldIsActive, remove: true)
                    
                    
                    Button(action: {
                            withAnimation{
                                textfieldIsActive.toggle()
                            }
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .rotationEffect(!textfieldIsActive ? Angle(degrees: 45) : .zero)
                            .transition(.scale)
                            .padding(.trailing, 5)
                            .foregroundColor(.azure)
                    })
                    
                }.frame(width: 30, height: 30, alignment: .center)

                TextField("Type text here...", text: $vm.message, onCommit: vm.sendMessage)
                    .underlineText(color: .azure)
                .onTapGesture {
                    withAnimation{
                        textfieldIsActive = true
                        vm.showingRecordingScreen = false
                    }
                }
                
                Button(action: vm.sendMessage , label: {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.azure)
                        .frame(width: 28, height: 28)
                        .padding(2)
                })
                
                
            }
            .padding(.bottom,5)
            .padding(.horizontal)
            .background(Color.firstBG.opacity(0.6).blur(radius: 5))
            
            .gesture(
                DragGesture()
                    .onEnded{ _ in
                        withAnimation{
                            hideKeyboard()
                        }
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                            withAnimation{
                                textfieldIsActive = true
                            }
                        }
                    }
        )

            
        }
    }
    
    func openCamera(){
        print("tapped")
        vm.loading = true
        vm.takeingPhoto.toggle()
        vm.showing.toggle()
        vm.hide()
        
        DispatchQueue.main.async {
            textfieldIsActive.toggle()
            
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(vm: ChatBotModel(), textfieldIsActive: .constant(true))
            .previewDevice("iPhone 12 Pro Max")
    }
}
