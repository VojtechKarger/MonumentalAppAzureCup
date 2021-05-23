//
//  LOGO.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 22.05.2021.
//

import SwiftUI

struct LOGO: View {
    
    var body: some View {

            GeometryReader { geo in
                let frame = geo.frame(in: .global)
                
                let height = frame.width / 7
                Image("monumen")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
//                HStack(alignment: .bottom , spacing: 0){
//                    M()
//                        .fill(Color.azure)
//                        .frame(width: frame.width / 6 ,height: height)
//                    Onumen()
//                        .fill(Color.primary)
//                        .frame(width: frame.width / 7 * 6, height: height, alignment: .center)
//                }
            }.padding()

    }
}





struct LOGO_Previews: PreviewProvider {
    static var previews: some View {
        LOGO()
    }
}
