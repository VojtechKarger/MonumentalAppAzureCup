//
//  ComunicationWithChatbot.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 17.05.2021.
//

import UIKit
import Combine
import Foundation
import SwiftUI
import AVFoundation
import MicrosoftCognitiveServicesSpeech


extension ChatBotModel {
    
    //MARK: - Comunication with chatbot
    func sendMessageToAzureBot(input: String) {
        
        var request = URLRequest(url: NetworkingData.chatbotUrl)
        request.httpMethod = NetworkingData.Method.POST.rawValue

        request.addValue(NetworkingData.chatbotAuthKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        previousUserQuery = input
        
        print(".....")
        let question = ChatBotQuestion(question: input)
        
        guard let encodedBody = try? JSONEncoder().encode(question) else{ return }
        
        request.httpBody = encodedBody
        
        let task = URLSession.shared.dataTask(with: request){ data, _, err in
            guard let data = data else { print(err ?? "error"); return }
            print(String(data: data, encoding: .utf8)!)
            
            guard let decoded = try? JSONDecoder().decode(BotsAnswer.self, from: data) else { print("jaaaaj");return }
            print(decoded)
            
            let advancedMessage: AdvancedMessage = self.getAdvancedMessage(decoded.answers[0].answer)
            DispatchQueue.main.async {
                self.betterMessage = advancedMessage
                
                if decoded.answers[0].context.prompts.count > 0 {
                    self.QnaAId = decoded.answers[0].context.prompts[0].qnaID
                    self.buttonText = decoded.answers[0].context.prompts[0].displayText
                    self.prompts = true
                }else{
                    self.prompts = false
                }
                
                let botMessage = Message(who: .bot, message: advancedMessage.plainText)
                
                withAnimation{
                    self.messages.append(botMessage)
                }
            }
            
        }
        
        task.resume()
    }
    
    //MARK: YES PLEASE Question (reaction on more information answer....)
    func yesPlease() {
        var request = URLRequest(url: NetworkingData.chatbotUrl)
        request.httpMethod = NetworkingData.Method.POST.rawValue

        request.addValue(NetworkingData.chatbotAuthKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let qnaID = QnaAId else { return }
        guard let prevouriousQuery = previousUserQuery else { return }

        withAnimation{
            prompts = false
            buttonText = ""
        }
        
        let context = Context(previousQnAID: qnaID - 1, previousUserQuery: prevouriousQuery)
        let question = ChatBotQuestion(question: "Yes, please!", context: context, qnaID: qnaID)
        
        guard let encodedBody = try? JSONEncoder().encode(question) else{ print("wrongModel"); return }
        
        request.httpBody = encodedBody
        
        let task = URLSession.shared.dataTask(with: request){ data, _, err in
            guard let data = data else { print(err ?? "error"); return }
            print(String(data: data, encoding: .utf8)!)
            
            guard let decoded = try? JSONDecoder().decode(BotsAnswer.self, from: data) else { print("jaaaaj");return }
            print(decoded)
            
            
            let advancedMessage = self.getAdvancedMessage(decoded.answers[0].answer)
            
            DispatchQueue.main.async {
                let textMessage = Message(who: .bot, message: advancedMessage.plainText)
                self.messages.append(textMessage)
                
                if let url = advancedMessage.otherLinks {
                    let link = Message(who: .bot, url: url)
                    self.messages.append(link)
                }
            }
            
            
            if let imageLink = advancedMessage.images {
                print("i have image link")
                print("Download Started")
                
                print("\(imageLink)")
                
                self.getData(from: imageLink) { data, response, error in
                    guard let data = data, error == nil else { print(error ?? "error"); return }
                    print(response?.suggestedFilename ?? imageLink.lastPathComponent)
                    print("Download Finished")
                    // always update the UI from the main thread
                    DispatchQueue.main.async() { [weak self] in
                        let img = UIImage(data: data)!
                        let messImg = Image(uiImage: img)
                        let mess = Message(who: .bot, image: messImg)
                        self?.messages.append(mess)
                    }
                }
                
                
                
            }
        
        }
        task.resume()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
}

