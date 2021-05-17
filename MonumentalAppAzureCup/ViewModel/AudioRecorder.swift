import Foundation
import AVFoundation

class MicrophoneMonitor: ObservableObject {
    
    // 1
    private var audioRecorder: AVAudioRecorder!
    private var timer: Timer?
    var audioPlayer: AVAudioPlayer!
    
    private var currentSample: Int
    private let numberOfSamples: Int
    
    @Published var voiceFilesUrls = [URL]()
    
    @Published public var recording = false
    // 2
    @Published public var soundSamples: [Float]
    
    init(numberOfSamples: Int) {
        self.numberOfSamples = numberOfSamples // In production check this is > 0.
        self.soundSamples = [Float](repeating: .zero, count: numberOfSamples)
        self.currentSample = 0
    }
    
    // 6
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        if audioSession.recordPermission != .granted {
            audioSession.requestRecordPermission { (isGranted) in
                if !isGranted {
                    fatalError("You must allow audio recording for this demo to work")
                }
            }
        }

        let recorderSettings: [String:Any] = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("\(UUID().uuidString).m4a")

        // 5
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recorderSettings)
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            
        } catch {
            fatalError(error.localizedDescription)
        }
        voiceFilesUrls.append(audioFilename)
        
        
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        recording = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
            // 7
            self.audioRecorder.updateMeters()
            self.soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
            self.currentSample = (self.currentSample + 1) % self.numberOfSamples
        })
    }
    
    func startPlaying(url : URL) {
      
        let playSession = AVAudioSession.sharedInstance()
            
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
            
        do {
            audioPlayer = try AVAudioPlayer(contentsOf : url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
                
            
                
        } catch {
            print("Playing Failed")
        }
                
    }

    func stopPlaying(url : URL){
      
        audioPlayer.stop()
      
    }
    
    
    func deleteAllRecording(){
        guard !voiceFilesUrls.isEmpty else { return }
        
        for i in voiceFilesUrls {
            do {
                try FileManager.default.removeItem(at: i)
            } catch {
                print("Can't delete file named: \(i)")
                return
            }
        }
        
        voiceFilesUrls.removeAll()
    }
    
    func stopRecording() {
        if let audioRecorder = audioRecorder {
            recording = false
            audioRecorder.stop()
            recording = false
        }
    }
    // 8
    deinit {
        timer?.invalidate()
        audioRecorder.stop()
    }
    
    
    
    
    
    func speak (sentense: String) {
        // Create an utterance.
        let utterance = AVSpeechUtterance(string: sentense)

        // Configure the utterance.
        utterance.rate = 0.57
        utterance.pitchMultiplier = 0.8
        utterance.postUtteranceDelay = 0.2
        utterance.volume = 2.5

        // Retrieve the British English voice.
        let voice = AVSpeechSynthesisVoice(language: "cz")

        // Assign the voice to the utterance.
        utterance.voice = voice
        
        
        // Create a speech synthesizer.
        let synthesizer = AVSpeechSynthesizer()

        // Tell the synthesizer to speak the utterance.
        synthesizer.speak(utterance)
    }
}
