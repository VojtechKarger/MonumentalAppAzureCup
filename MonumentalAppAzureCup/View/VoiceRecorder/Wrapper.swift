//
//  Wrapper.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 28.05.2021.
//

import UIKit
import SwiftUI

// 1.
struct Wrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper>) -> CustomView {
        return CustomView()
    }
    
    func updateUIViewController(_ uiView: CustomView, context: UIViewControllerRepresentableContext<Wrapper>) {
        
    }

}
