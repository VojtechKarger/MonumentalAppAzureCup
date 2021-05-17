//
//  ChatbotStruct.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 09.05.2021.
//

import SwiftUI

enum Who {
    case bot, user
}

struct AdvancedMessage {
    
    var images: URL?
    var otherLinks: URL?
    var plainText: String

}

class Message: Identifiable {
    
    var id = UUID()
    var who: Who
    var message: String?
    var image: Image?
    var url: URL?
    
    
    init(who: Who, message: String) {
        self.who = who
        self.message = message
        self.image = nil
        self.url = nil
    }
    
    init(who: Who, image: Image) {
        self.who = who
        self.message = nil
        self.image = image
        self.url = nil
    }
    
    init(who: Who, url: URL ) {
        self.who = who
        self.message = nil
        self.image = nil
        self.url = url
    }
    
}



