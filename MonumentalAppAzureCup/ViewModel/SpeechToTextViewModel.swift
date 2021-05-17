//
//  SpeechToTextViewModel.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 14.05.2021.
//

import Combine
import SwiftUI


extension ChatBotModel {
//MARK: - Geting data from ress
    
    func getUrls(_ input: String) ->[URL] {
        var urls: [URL] = []
        
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))

        for match in matches {
            guard let range = Range(match.range, in: input) else { continue }
            let url = input[range]
            print(url)
            urls.append(URL(string: "\(url)")!)
        }
        return urls
    }
    
    func getAdvancedMessage(_ input: String) -> AdvancedMessage {
        let arr = getComponents(input)
        
        let images = returnImagesURL(arr)
        let links = returnLinksURL(arr)
        let plaintext = getPlainTextFromRess(input)
        
        return AdvancedMessage(images: images, otherLinks: links, plainText: plaintext)
    }
    
    func getComponents(_ input: String) -> [String] {
        let arr = input.components(separatedBy: "[")
        print(arr)
        return arr
    }
    
    func returnImagesURL(_ input: [String]) -> URL?{
        guard input.count > 0 else { return nil }
        
        for i in input {
            if i.contains("image"){
                if getUrls(i).count > 0 {
                    return getUrls(i)[0]
                }
            }
        }
        return nil
    }
    
    func returnLinksURL(_ input: [String]) -> URL?{
        guard input.count > 0 else { return nil }
        for i in input {
            if !i.contains("image"){
                if getUrls(i).count > 0 {
                    return getUrls(i)[0]
                }
            }
        }
        return nil
    }
    
    func getPlainTextFromRess(_ input: String) -> String{
        let arr = input.components(separatedBy: "[")
        print(arr)
        
        let str = arr[0]
        var finalStr = ""
        
        for i in str {
            if i != "*"{
                finalStr += "\(i)"
            }
        }
        return finalStr
    }
}
