// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import ObjectMapper

// MARK: - Welcome
class GameResponse: Mappable {
    var count: Int?
    var next, previous: String?
    var results: [Result]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

// MARK: - Result
class Result: Mappable {
    var id: Int?
    var name, released: String?
    var backgroundImage: String?
    var rating, ratingTop: Int?
    var suggestionsCount: Int?
    var updated: Date?
    var reviewsCount: Int?
    var communityRating: Int?
    var platforms: [Platform]?
    var genres: [Genre]?
    var parentPlatformPlatform: [ParentPlatformPlatform]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        released <- map["released"]
        backgroundImage <- map["background_image"]
        rating <- map["rating"]
        ratingTop <- map["rating_top"]
        suggestionsCount <- map["suggestions_count"]
        updated <- map["updated"]
        reviewsCount <- map["reviews_count"]
        communityRating <- map["community_rating"]
        platforms <- map["platforms"]
        parentPlatformPlatform <- map["parent_platforms"]
    }
}

// MARK: - Platform
class Platforms: Mappable {
    var platform: Platform?
    var releasedAt: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        platform <- map["Platform"]
        releasedAt <- map["released_at"]
    }
}

// MARK: - Platform
class Platform: Mappable {
    var id: Int?
    var name, slug: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
    }
}

// MARK: - ParentPlatformPlatform
class ParentPlatformPlatform: Mappable {
    var id: Int?
    var name, slug: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
    }
}

// MARK: - Genre
class Genre: Mappable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var language: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
        language <- map["language"]
    }
}
