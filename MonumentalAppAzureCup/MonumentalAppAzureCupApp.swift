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
    @StateObject var am = MicrophoneMonitor(numberOfSamples: 4)
    var body: some Scene {
        WindowGroup {
            Chatbot(am: am)
                .environmentObject(vm)
        }
    }
}
