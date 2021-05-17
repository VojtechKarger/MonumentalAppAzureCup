//
//  Chatbotmodel.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 09.05.2021.
//

import UIKit
import Combine
import Foundation
import SwiftUI
import AVFoundation
import MicrosoftCognitiveServicesSpeech




class ChatBotModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @Published var messages: [Message] = [Message(who: .user, message: "ahoj"),Message(who: .bot, message: "ahoj"),Message(who: .user, image: Image("pozadiMainScreen")),Message(who: .bot, message: "Tynsky Chram"),Message(who: .bot, image: Image("bgImage1")), Message(who: .user, message: "instagram"),Message(who: .bot, url: URL(string: "https://www.instagram.com")!), Message(who: .user, message: "google"),Message(who: .bot, url: URL(string: "https://www.google.cz")!)]
    
    @Published var picData = Data(count: 0)
    @Published var isTaken = false
    
    @Published var message = String()
    @Published var color: Color = Color.gray
    
    @Published var selectedImage: Image?
    
    var speechUtterance: AVSpeechUtterance!
    var speechSynthesizer: AVSpeechSynthesizer!
    
    @Published var showing = false
    
    @Published var loading = false
    
    @Published var takeingPhoto = false
    
    @Published var showingRecordingScreen = false
    
    @Published var betterMessage: AdvancedMessage?
    
    //comunication with chatbot
    var QnaAId: Int?
    var previousUserQuery: String?
    
    @Published var prompts = false
    @Published var buttonText: String? = ""
    
    
    
    var lastestMessage: Message {
        return messages[messages.count - 1]
    }
    
    
    //helper func for ui
    func hideRecordingScreen() {
        withAnimation{
            showingRecordingScreen.toggle()
        }
    }
    func hide() {
        showingRecordingScreen = false
    }
    
    func scroll(scroll: ScrollViewProxy) {
        if self.messages.count > 1{
            scroll.scrollTo(self.messages[self.messages.count - 1].id)
        }
    }
    
    
    func sendMessage() {
        guard !message.isEmpty else { return }
        
        let messageObject = Message(who: .user, message: message)
        withAnimation{
            messages.append(messageObject)
        }
        
        //MARK: Sending message to bot
        sendMessageToAzureBot(input: message)
        
        message = String()
    }
    
    
    func sendImage() {
        let imageData = picData

        let image = UIImage(data: imageData)!
        // adding message to chat
        let message = Message(who: .user, image: Image(uiImage: image))
        withAnimation{
            self.messages.append(message)
        }
        
        let url = NetworkingData.urlCV
        var request = URLRequest(url: url)
        request.httpMethod = NetworkingData.Method.POST.rawValue
        request.addValue(NetworkingData.predictionKeyCV, forHTTPHeaderField: "Prediction-Key")
        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.httpBody = imageData
        print("working")
        
        URLSession.shared.dataTask(with: request){ data,ress,err in
            
            guard let data = data else { print("nejsou data");return }
            print(String(data: data, encoding: .utf8)!)
            
            guard let decoded = try? JSONDecoder().decode(NetworkingModel.self, from: data) else { print("chyba");return }
        
            print(decoded)
            
            self.sendMessageToAzureBot(input: decoded.predictions[0].tagName)
            
        }.resume()
        
        
    }
    
    func users(who: Who) -> Bool{
        if who == .user{
            return true
        }
        return false
    }
    
//MARK: - text to speech
    
    
    func speak(messafe: String){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            fatalError(error.localizedDescription)
        }
        
        
        speechSynthesizer = AVSpeechSynthesizer()
        
        // Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
        speechUtterance = AVSpeechUtterance(string: messafe)
        
        
        // Line 4. Specify the voice. It is explicitly set to English here, but it will use the device default if not specified.
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        if speechSynthesizer.isSpeaking {
        print("Speaking")
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0) ?? AVSpeechBoundary(rawValue: 1)!)
        }
        // Line 5. Pass in the urrerance to the synthesizer to actually speak.
        speechSynthesizer.speak(speechUtterance)
    }
}

