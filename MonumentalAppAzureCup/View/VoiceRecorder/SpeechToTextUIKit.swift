//
//  SpeechToTextUIKit.swift
//  MonumentalAppAzureCup
//
//  Created by vojta on 27.05.2021.
//
import MicrosoftCognitiveServicesSpeech
import UIKit

class CustomView: UIViewController {
    
    lazy var button: UIButton = {
        var btn = UIButton()
        btn.layer.borderColor = UIColor(.azure).cgColor
        btn.layer.backgroundColor = UIColor(.azure).cgColor
        btn.layer.borderWidth = 0
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.addTarget(self, action:#selector(self.fromMicButtonClicked), for: .touchUpInside)
        
        let sublayer = CALayer()
        sublayer.frame = CGRect(x: -5, y: -5, width: 60, height: 60)
        sublayer.borderWidth = 2
        sublayer.borderColor = UIColor(.azure).cgColor
        sublayer.cornerRadius = 30
        
        btn.layer.insertSublayer(sublayer, at: 9999999)
        
        return btn
    }()
    
    
    var sub: String!
    var region: String!
    
    override func viewDidLoad() {
        sub = "3e592cabca284a3cbd03a446f68a1e1b"
        region = "eastus"
        
        print(self.view.frame)
        self.view.backgroundColor = UIColor(.firstBG)
        
        setUpViews()
        setUpConstraits()
        
    }
    
    func setUpViews() {
        view.addSubview(button)
    }
    
    func setUpConstraits() {
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
        
        
    }
    
    
    
    
    @objc func fromMicButtonClicked() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.recognizeFromMic()
        }
    }
    
    func recognizeFromMic() {
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
        
        reco.addRecognizingEventHandler() {reco, evt in
            print("intermediate recognition result: \(evt.result.text ?? "(no result)")")
            self.updateLabel(text: evt.result.text, color: UIColor(.azure.opacity(0.5)))
        }
        
        updateLabel(text: "Listening ...", color: UIColor(.azure.opacity(0.5)))
        print("Listening...")
        
        let result = try! reco.recognizeOnce()
        print("recognition result: \(result.text ?? "(no result)")")
        updateLabel(text: result.text, color: UIColor(.azure))
    }
    
    func updateLabel(text: String?, color: UIColor) {
        DispatchQueue.main.async { [weak self] in
            NotificationCenter.default.post(name: NSNotification.Name.updateLabel, object: nil, userInfo: ["text": text ?? ""])
            self?.button.layer.backgroundColor = color.cgColor
        }
    }
}



extension Notification.Name {
    static let updateLabel = Notification.Name.init("labelUpdate")
}
