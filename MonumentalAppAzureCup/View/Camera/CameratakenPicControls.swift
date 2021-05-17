//
//  CameratakenPicControls.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI

struct CameratakenPicControls: View {
    @ObservedObject var vm: ChatBotModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Button(action: vm.reTake, label: {
                    Image("retake")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32, alignment: .center)
                })
                .padding()
                Spacer()
                Button(action: {
                    vm.sendImage()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("sent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                }).padding()
            }
        }
    }
}

struct CameratakenPicControls_Previews: PreviewProvider {
    static var previews: some View {
        CameratakenPicControls(vm: ChatBotModel())
    }
}
