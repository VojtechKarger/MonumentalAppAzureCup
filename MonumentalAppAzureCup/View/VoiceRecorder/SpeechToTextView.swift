//
//  SpeechToTextView.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 14.05.2021.
//

import SwiftUI

struct SpeechToTextView: View {
    @EnvironmentObject var vm: ChatBotModel
    
    var body: some View {
        ZStack {
            Button(action: {
                vm.recognizeMic()
            }, label: {
                Text("record")
        })
            VStack{
                Divider()
                    .background(Color.azure)
                HStack{
                    Spacer()
                    Button(action: {
                        vm.hideRecordingScreen()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.azure)
                            .frame(width: 30, height: 30, alignment: .center)
                            .rotationEffect(Angle(degrees: 45))
                    })
                    .padding(.trailing, 10)
                    
                }
                Spacer()
            }
        }
    }
}

struct SpeechToTextView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechToTextView()
    }
}
