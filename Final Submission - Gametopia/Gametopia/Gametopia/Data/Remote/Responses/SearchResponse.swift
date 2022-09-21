//
//  SearchResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 13/09/22.
//

import Foundation
import ObjectMapper

// MARK: - Welcome
class SearchResponse: Mappable {
    var count: Int?
    var next, previous: String?
    var results: [SearchResult]?
    
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

class SearchResult: Mappable{
    var id: Int?
    var name, slug: String?
    var playtime: Int?
    var released: String?
    var rating: Double?
    var score: String?
    var backgroundImage: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        playtime <- map["playtime"]
        released <- map["released"]
        rating <- map["rating"]
        score <- map["score"]
        backgroundImage <- map["background_image"]
    }
}
