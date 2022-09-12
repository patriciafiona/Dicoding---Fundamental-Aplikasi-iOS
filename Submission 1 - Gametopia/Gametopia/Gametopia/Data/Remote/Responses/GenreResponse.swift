//
//  GenreResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import Foundation
import ObjectMapper

// MARK: - Welcome
class GenreResponse: Mappable {
    var count: Int?
    var next, previous: String?
    var results: [GenreResult]?
    
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
class GenreResult: Mappable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var games: [GameInGenre]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
        games <- map["games"]
    }
}

// MARK: - Game
class GameInGenre: Mappable {
    var id: Int?
    var name, slug: String?
    var added: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        added <- map["added"]
    }
}
