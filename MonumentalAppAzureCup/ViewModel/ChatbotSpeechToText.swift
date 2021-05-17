//
//  ChatbotSpeechToText.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 17.05.2021.
//

import MicrosoftCognitiveServicesSpeech
import SwiftUI


extension ChatBotModel {
    
    func recognizeMic() {
        //auth...
        let sub = NetworkingData.subSpeechToText
        let region = NetworkingData.regionSpeechToText

        var speechConfig: SPXSpeechConfiguration?
        
        do {
            try speechConfig = SPXSpeechConfiguration(subscription: sub, region: region)
        } catch {
            print("error \(error) happened")
            speechConfig = nil
        }
        speechConfig?.speechRecognitionLanguage = "en-US"
        
        let audioConfig = SPXAudioConfiguration()
        
        let reco = try! SPXSpeechRecognizer(speechConfiguration: speechConfig!, audioConfiguration: audioConfig)
        
        reco.addRecognizingEventHandler { reco, evt in
            print("intermediate recognition result: \(evt.result.text ?? "(no result)")")
            self.updateLabel(text: evt.result.text, color: .gray)
        }
        
        updateLabel(text: "Listening ...", color: .gray)
        print("Listening...")
        
        let result = try! reco.recognizeOnce()
        print("recognition result: \(result.text ?? "(no result)")")
        updateLabel(text: result.text, color: .black)
        
        
    }

    func updateLabel(text: String?, color: UIColor) {
        DispatchQueue.main.async {
            self.message = text!
            self.color = Color(color)
        }
    }
}
