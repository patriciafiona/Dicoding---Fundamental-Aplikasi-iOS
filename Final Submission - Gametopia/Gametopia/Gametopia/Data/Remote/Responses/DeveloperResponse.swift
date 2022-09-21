//
//  DeveloperResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 13/09/22.
//

import ObjectMapper

// MARK: - Welcome
class DeveloperResponse: Mappable {
    var count: Int?
    var next, previous: String?
    var results: [DeveloperResult]?
    
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
class DeveloperResult: Mappable {
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
