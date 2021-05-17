//
//  ExtensionView.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 11.05.2021.
//

import SwiftUI
import UIKit

//MARK: - Hide keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


//MARK: - Conditionaly hidding View
extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}



struct AdaptiveStack<Content>: View where Content: View {
    @Binding var horizontal: Bool
    
    var content: () -> Content
    
    var body: some View {
        if horizontal == true {
            HStack{
                content()
            }
        }else {
            VStack{
                content()
            }
        }
    }
}

