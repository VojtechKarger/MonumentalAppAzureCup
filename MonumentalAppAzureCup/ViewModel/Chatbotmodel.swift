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
    
    var lastestMessage: Message {
        return messages[messages.count - 1]
    }
    
    func hideRecordingScreen() {
        withAnimation{
            showingRecordingScreen.toggle()
        }
    }
    func hide() {
        showingRecordingScreen = false
    }
    
    func sendMessage() {
        guard !message.isEmpty else { return }
        
        let messageObject = Message(who: .user, message: message)
        withAnimation{
            messages.append(messageObject)
        }
        
        //MARK: - Sending message to bot
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
    
//MARK: - Speech To Text
    
    var sub = NetworkingData.subSpeechToText
    var region = NetworkingData.regionSpeechToText
    
    func recognizeMic() {
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

//MARK: - Comunication with ChatBot
    
    
    private var QnaAId: Int?
    private var previousUserQuery: String?
    
    @Published var prompts = false
    @Published var buttonText: String? = ""
    
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
    
    //MARK: - YES PLEASE Question (reaction on more information answer....)
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
    
    
    
    
//MARK: - Camera MODEL
    @Published var isTaken = false
    
    @Published var liveClassificationOn = false
    
    @Published var classificationLabel = ""
    
    @Published var isZoomed = false
    @Published var currentZoom: CGFloat = 0
    @Published var finalZoom: CGFloat = 1
    
    @Published var items = [Any]()
    
    @Published var session = AVCaptureSession()
    
    @Published var device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    
    @Published var alert = false
    
    @Published var text = String()
    
//MARK: - model for local classfication
//    let model: TestML = {
//        do {
//            let config = MLModelConfiguration()
//            return try TestML(configuration: config)
//        } catch {
//            print(error)
//            fatalError("Couldn't create TestML model")
//        }
//    }()
//MARK: -
    // since were going to read pic data....
    @Published var output = AVCapturePhotoOutput()
    
    @Published var secondOutput = AVCaptureVideoDataOutput()
    
    // preview....
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    // Pic Data...
    
    @Published var isSaved = false
    
    @Published var picData = Data(count: 0)
    
    func Check(){
        
        // first checking if cameras got permission...
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Setting Up Session
            setUp()
            return
        case .notDetermined:
            // retusting for permission....
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                
                if status{
                    self.setUp()
                }
            }
        case .denied:
            self.text = "acces to camera dennied"
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp(){
        
        // setting up camera...
        
        do{
            
            // setting configs...
            self.session.beginConfiguration()
            
            // change for your own...
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            // checking and adding to session...
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            // same for output....
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            //presetup second output for live classification...
            secondOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func reconfigurate() {
        DispatchQueue.global(qos: .background).async {
            self.session.beginConfiguration()
            if !self.liveClassificationOn {
                self.session.removeOutput(self.output)
                self.session.addOutput(self.secondOutput)
            }else{
                self.session.removeOutput(self.secondOutput)
                self.session.addOutput(self.output)
            }
            DispatchQueue.main.async {
                withAnimation{
                    self.liveClassificationOn.toggle()
                }
            }
            self.session.commitConfiguration()
            print(self.session.outputs)
        }
    }
    
    
    
    func zoom() {
        
        try! device?.lockForConfiguration()
        
        if self.isZoomed {
            device?.ramp(toVideoZoomFactor: device!.minAvailableVideoZoomFactor , withRate: 2 )
            finalZoom = device!.minAvailableVideoZoomFactor
        }else{
            device?.ramp(toVideoZoomFactor: 2 , withRate: 2 )
            finalZoom = 2
        }
        
        self.isZoomed.toggle()
        device?.unlockForConfiguration()
        
    }
    
    func zoomWithPinch() {
        try! device?.lockForConfiguration()
        if device!.maxAvailableVideoZoomFactor > currentZoom + finalZoom{
            if device!.minAvailableVideoZoomFactor < currentZoom + finalZoom {
                device?.videoZoomFactor = currentZoom + finalZoom
                self.isZoomed = true
            }else {
                device?.videoZoomFactor = device!.minAvailableVideoZoomFactor
                self.isZoomed = false
            }
        }else{
            device?.videoZoomFactor = device!.maxAvailableVideoZoomFactor
            self.isZoomed = true

        }
        
        device?.unlockForConfiguration()
    }

    
    // take and retake functions...
    
    func takePic(){
        
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                
                withAnimation{ self.isTaken.toggle() }
            }
        }
    }
    
//old method
//    func classify() {
//        guard let image = UIImage(data: self.picData) else{ return }
//        let url = URL(string: "https://monumentclassifiertrain.cognitiveservices.azure.com/customvision/v3.0/Prediction/4e3e5ac4-18ad-409c-a370-ae274cdd615a/classify/iterations/MonumentClassifier/image")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("4169521e7c134b16810fa15838e0af00", forHTTPHeaderField: "Prediction-Key")
//        request.addValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
//        request.httpBody = image.jpegData(compressionQuality: 0.5)
//        print("working")
//        URLSession.shared.dataTask(with: request){ data,ress,err in
//
//            guard let data = data else { print("nejsou data");return }
//            print(String(data: data, encoding: .utf8)!)
//
//            guard let decoded = try? JSONDecoder().decode(NetworkingModel.self, from: data) else { print("chyba");return }
//            DispatchQueue.main.async { [self] in
//                print(decoded)
//                self.text = decoded.predictions[0].tagName
//                self.alert = true
//            }
//        }.resume()
//
//    }
    
    func reTake(){
        
        DispatchQueue.global(qos: .background).async {
            
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{ self.isTaken = false }
                //clearing ...
                self.isSaved = false
                self.picData = Data(count: 0)
            }
        }
    }
    

    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil{
            return
        }
        
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else{return}
        
        self.picData = imageData
    }
    //MARK: Není potřeba
//    func savePic(){
//
//        guard let image = UIImage(data: self.picData) else{return}
//
//        // saving Image...
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//
//        self.isSaved = true
//
//        print("saved Successfully....")
//    }
    
    func focus(location: CGPoint){
        guard let device = device else { return }
        
        do{
            try device.lockForConfiguration()
            device.focusPointOfInterest = location
            device.focusMode = .continuousAutoFocus
//            device.focusMode = .autoFocus
//            device.focusMode = .locked
            device.exposurePointOfInterest = location
            device.exposureMode = .continuousAutoExposure
            device.unlockForConfiguration()
        }catch{
            
        }
    }
    func share() {
        guard let image = UIImage(data: self.picData) else{return}
        items.removeAll()
        items.append(image)
    }
    
    //MARK: - LIVE classification logic...
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//
//        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
//        guard let classify = try? model.prediction(image: pixelBuffer) else{ print("...") ; return }
//
//        print(classify.classLabelProbs)
//
//        DispatchQueue.main.async {
//            if classify.classLabelProbs[classify.classLabel]! > 0.7 {
//                self.classificationLabel = classify.classLabel
//            }else{
//                self.classificationLabel = ""
//            }
//        }
//    }
}

