//
//  ChatbotAnswer.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 14.05.2021.
//

import Foundation

// MARK: - Welcome
struct BotsAnswer: Codable {
    var answers: [Answer]
    var activeLearningEnabled: Bool
}

// MARK: - Answer
struct Answer: Codable {
    var questions: [String]
    var answer: String
    var score, id: Double?
    var source: String?
    var isDocumentText: Bool?
    var context: AnswerContext
}

// MARK: - Context
struct AnswerContext: Codable {
    var isContextOnly: Bool
    var prompts: [Prompt]
}

// MARK: - Prompt
struct Prompt: Codable {
    var displayOrder, qnaID: Int?
    var displayText: String?

    enum CodingKeys: String, CodingKey {
        case displayOrder
        case qnaID = "qnaId"
        case displayText
    }
}

