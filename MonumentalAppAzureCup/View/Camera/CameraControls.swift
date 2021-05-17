//
//  CameraControls.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI

struct CameraControls: View {
    @ObservedObject var vm: ChatBotModel
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Button(action: vm.zoom ){
                    Image(systemName: !vm.isZoomed ? "plus.circle":"minus.circle" )
                        .font(.system(size: 30))
                        .foregroundColor(.azure)
                }.offset(x: -45, y: -45)
                
                
                Button(action: vm.takePic, label: {
                    ZStack{
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: 65, height: 65)
                        
                        Circle()
                            .stroke(Color.azure,lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                    
                })
                
            }
        }
    }
}




struct CameraControls_Previews: PreviewProvider {
    static var previews: some View {
        CameraControls(vm: ChatBotModel())
    }
}
