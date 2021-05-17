//
//  MonumentalAppAzureCupApp.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 17.05.2021.
//

import SwiftUI

@main
struct MonumentalAppAzureCupApp: App {
    @StateObject var vm = ChatBotModel()
   
    var body: some Scene {
        WindowGroup {
            Chatbot()
                .environmentObject(vm)
        }
    }
}
