//
//  ModelNetworking.swift
//  Pamatkovac verze 3
//
//  Created by vojta on 07.05.2021.
//

import Foundation


// MARK: - NetworkingModel
struct NetworkingModel: Codable {
    let id, project, iteration, created: String
    let predictions: [Prediction]
}

// MARK: - Prediction
struct Prediction: Codable {
    let probability: Double
    let tagID, tagName: String

    enum CodingKeys: String, CodingKey {
        case probability
        case tagID = "tagId"
        case tagName
    }
}
