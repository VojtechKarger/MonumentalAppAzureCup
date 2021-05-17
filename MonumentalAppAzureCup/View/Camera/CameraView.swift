//
//  CameraView.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 07.05.2021.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var model: ChatBotModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
//            CameraPreview(camera: model)
//                .ignoresSafeArea(.all, edges: .all)
//                .onClickGesture(count: 1, coordinateSpace: .local) { (location) in
//                    model.focus(location: location)
//                }
//                .gesture(
//                    MagnificationGesture()
//                        .onChanged { amount in
//                            model.currentZoom = amount - 1
//                            model.zoomWithPinch()
//                        }
//                        .onEnded { amount in
//                            model.finalZoom += model.currentZoom
//                            model.currentZoom = 0
//                        }
//                        )
//            
            VStack{
                HStack {
                    Button(action: hideCamera, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.azure)
                            .scaledToFit()
                            .animation(.easeInOut)
                            .rotationEffect(model.isTaken ? Angle(degrees: 45) : Angle(degrees: 225))
                            .frame(width: 32, height: 32, alignment: .center)
                            .padding(8)
                    })
                    .padding(8)
                    Spacer()
                }
                Spacer()
            }
            
            if !model.isTaken {
                CameraControls(vm: model)
            }else{
                CameratakenPicControls(vm: model)
            }
            
        }.onAppear(perform: {
            model.Check()
            model.loading = false
        })
    }
    
    func hideCamera() {
        withAnimation{
            presentationMode.wrappedValue.dismiss()
            model.reTake()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(model: ChatBotModel())
            
    }
}
