//
//  GameResponses.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import UIKit
import Foundation


enum DownloadState {
  case new, downloaded, failed
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct Welcome: Codable {
    let count: Int
    let next, previous: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating, ratingTop: Int
    let ratings: AddedByStatus
    let ratingsCount: Int
    let reviewsTextCount: String
    let added: Int
    let addedByStatus: AddedByStatus
    let metacritic, playtime, suggestionsCount: Int
    let updated: Date
    let esrbRating: EsrbRating
    let platforms: [Platform]

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case esrbRating = "esrb_rating"
        case platforms
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let slug, name: String
}

// MARK: - Platform
struct Platform: Codable {
    let platform: EsrbRating
    let releasedAt: String
    let requirements: Requirements

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    let minimum, recommended: String
}

