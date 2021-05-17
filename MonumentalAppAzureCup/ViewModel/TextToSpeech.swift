//
//  TextToSpeech.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 17.05.2021.
//

import MicrosoftCognitiveServicesSpeech
import SwiftUI


extension ChatBotModel {
    
    func synthesisToSpeaker(messageToSpeak: String) {
        let sub = NetworkingData.subSpeechToText
        let region = NetworkingData.regionSpeechToText
        
        var speechConfig: SPXSpeechConfiguration?
            
        print("something")
        
        do {
            try speechConfig = SPXSpeechConfiguration(subscription: sub, region: region)
        } catch {
            print("error \(error) happened")
            speechConfig = nil
        }
        
    
        
        let synthesizer = try! SPXSpeechSynthesizer(speechConfig!)
        if messageToSpeak.isEmpty {
            print("something wrong")
            return
        }
        print("ahooj")
        let result = try! synthesizer.speakText(messageToSpeak)
        print("loading......")
        if result.reason == SPXResultReason.canceled {
            let cancellationDetails = try! SPXSpeechSynthesisCancellationDetails(fromCanceledSynthesisResult: result)
            print("cancelled, detail: \(cancellationDetails.errorDetails!) ")
        }
    }
    
}
