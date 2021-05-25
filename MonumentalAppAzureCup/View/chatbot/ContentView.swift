//
//  ContentView.swift
//  Playground
//
//  Created by vojta on 13.05.2021.
//
import SwiftUI

struct ActivityIndicatorChatBot: View {
    
    @State var anim: CGFloat = 0
    let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        HStack(spacing: 3.5){
            Circle()
                .fill(Color.secondary.opacity(0.6))
                .offset(y: anim)
                .animation(.easeInOut(duration: 0.5))
            Circle()
                .fill(Color.secondary.opacity(0.6))
                .offset(y: anim)
                .animation(.easeInOut(duration: 0.5).delay(0.5))
            Circle()
                .fill(Color.secondary.opacity(0.6))
                .offset(y: anim)
                .animation(.easeInOut(duration: 0.5).delay(1))
                
        }
        .transition(.scale)
        .onAppear(perform: {
            anim -= 5
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                anim = 0
            }
        })
        .onReceive(timer, perform: { _ in
            anim -= 5
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                anim = 0
            }
            
        })
        .padding(.horizontal,16)
        .padding(.vertical, 4)


    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorChatBot()
            .previewLayout(.fixed(width: 460, height: 260))
            
    }
}
