//
//  VoiceRecorder.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI

struct VoiceRecorder: View {

    @EnvironmentObject var vm: ChatBotModel
    
    @EnvironmentObject var mic: MicrophoneMonitor
        // 2
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        let level = max(0.2, CGFloat(level) + 50) / 2 // between 0.1 and 25
        
        return CGFloat(level * (200 / 25)) // scaled to max at 300 (our height of our bar)
    }
        
    let timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    
    @State var animated = CGFloat.zero
    
    var body: some View {

        VStack {
            Divider()
            HStack(spacing: 4) {
                VStack {
                    Spacer()
                    Button(action: !mic.recording ? mic.startRecording : mic.stopRecording, label: {
                        Image(systemName: !mic.recording ? "record.circle" : "stop.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.azure)
                    }).padding()
                }
            
                Spacer()
                ForEach(mic.soundSamples, id: \.self) { level in
                    BarView(value: self.normalizeSoundLevel(level: level))
                }
            
                Spacer()
                VStack{
                    Button(action: {
                        vm.hideRecordingScreen()
                        mic.stopRecording()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.azure)
                            .frame(width: 30, height: 30, alignment: .center)
                            .rotationEffect(Angle(degrees: 45))
                    })
                    .padding(.leading, 25)

                    Spacer()
                    Button(action: {
                        mic.stopRecording()
                        vm.hide()
                        
                        if let lastUrl = mic.voiceFilesUrls.last {
                            let message = Message(who: .user, url: lastUrl)
                        
                        vm.messages.append(message)
                        }
                    }, label: {
                        Image(systemName: "paperplane.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.azure2)
                            .frame(width: 50, height: 50, alignment: .center)
                            .rotationEffect(Angle(degrees: 45))
                    }).padding()
                }
            }
        }.background(Color.firstBG)
    
        
    }
    
    
}

struct VoiceRecorder_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRecorder()
            .frame(height: 200, alignment: .center)
    }
}



let numberOfSamples: Int = 3

struct BarView: View {
   // 1
    var value: CGFloat

    var body: some View {
        ZStack {
           // 2
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [.azure,.azure2 ]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                // 3
                .frame(width: 50, height: value)
        }
    }
}
