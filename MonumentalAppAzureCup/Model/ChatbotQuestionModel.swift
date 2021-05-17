//
//  ChatbotQuestionModel.swift
//  
//
//  Created by vojta on 14.05.2021.
//

import Foundation


class ChatBotQuestion: Encodable {
    var question: String
    var context: Context?
    var qnaID: Int?
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case question, context
        case qnaID = "qnaId"
        case userID = "userId"
    }
    
    init(question: String) {
        self.question = question
        self.userID = nil
        self.qnaID = nil
        self.context = nil
    }
    
    init(question: String, context: Context, qnaID: Int) {
        self.question = question
        self.context = context
        self.qnaID = qnaID
        self.userID = "Default"
    }
}

// MARK: - Context
struct Context: Encodable {
    var previousQnAID: Int
    var previousUserQuery: String

    enum CodingKeys: String, CodingKey {
        case previousQnAID = "previousQnAId"
        case previousUserQuery
    }
}
