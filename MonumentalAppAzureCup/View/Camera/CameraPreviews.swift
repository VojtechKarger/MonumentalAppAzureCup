//
//  CameraPreviews.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 14.05.2021.
//

//import Foundation
//import AVFoundation
//import SwiftUI
//
//struct CameraPreview: UIViewRepresentable {
//
//    @ObservedObject var camera : ChatBotModel
//
//    func makeUIView(context: Context) ->  UIView {
//
//        let view = UIView(frame: UIScreen.main.bounds)
//
//        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
//        camera.preview.frame = view.frame
//
//        // Your Own Properties...
//        camera.preview.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(camera.preview)
//
//        // starting session
//        camera.session.startRunning()
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//    }
//}
