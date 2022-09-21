//
//  DetailGenre.swift
//  Gametopia
//
//  Created by Patricia Fiona on 15/09/22.
//

import Foundation
import ObjectMapper

class GenreDetailResponse: Mappable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var description: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
        description <- map["description"]
    }
}
