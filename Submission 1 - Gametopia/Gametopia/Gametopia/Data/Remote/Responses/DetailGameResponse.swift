//
//  DetailGameResponse.swift
//  Gametopia
//
//  Created by Patricia Fiona on 14/09/22.
//

import Foundation
import ObjectMapper

// MARK: - DetailGameResponse
class DetailGameResponse: Mappable {
    var id: Int?
    var slug, name, nameOriginal, description: String?
    var released: String?
    var updated: String?
    var backgroundImage: String?
    var backgroundImageAdditional: String?
    var website: String?
    var rating: Double?
    var added: Int?
    var playtime: Int?
    var achievementsCount: Int?
    var ratingsCount, suggestionsCount: Int?
    var reviewsCount: Int?
    var parentPlatforms: [Platform]?
    var platforms: [DetailPlatform]?
    var stores: [StoreDetails]?
    var developers: [Developer]?
    var genres: [GenreInDetails]?
    var tags: [Tag]?
    var publishers: [Publisher]?
    var descriptionRaw: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        nameOriginal <- map["name_original"]
        description <- map["description"]
        released <- map["released"]
        updated <- map["released"]
        backgroundImage <- map["background_image"]
        backgroundImageAdditional <- map["background_image_additional"]
        website <- map["website"]
        rating <- map["rating"]
        added <- map["added"]
        playtime <- map["playtime"]
        achievementsCount <- map["achievements_count"]
        ratingsCount <- map["ratings_count"]
        reviewsCount <- map["reviews_count"]
        suggestionsCount <- map["suggestions_count"]
        parentPlatforms <- map["parent_platforms"]
        platforms <- map["platforms"]
        stores <- map["stores"]
        developers <- map["developers"]
        genres <- map["genres"]
        tags <- map["tags"]
        publishers <- map["publishers"]
        descriptionRaw <- map["descriptionRaw"]
    }
}

class DetailPlatform: Mappable{
    var plaform: PlatformDetails?
    var releasedAt: String?
    var requirements: PlatformRequirement?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        plaform <- map["plaform"]
        releasedAt <- map["released_at"]
        requirements <- map["requirements"]
    }
}

class PlatformDetails: Mappable{
    var id: Int?
    var name, slug: String?
    var image, yearEnd, yearStart: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        image <- map["image"]
        yearEnd <- map["year_end"]
        yearStart <- map["year_start"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
    }
}

class PlatformRequirement: Mappable{
    var minimum: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        minimum <- map["minimum"]
    }
}

class StoreDetails: Mappable{
    var id: Int?
    var url: String?
    var store: Store?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
        store <- map["Store"]
    }
}

class Store: Mappable{
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var domain: String?
    var imageBackground: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        domain <- map["domain"]
        imageBackground <- map["image_background"]
    }
}

class Developer: Mappable{
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
    }
}

class Publisher: Mappable{
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
    }
}

class GenreInDetails: Mappable{
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
    }
}

class Tag: Mappable{
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        slug <- map["slug"]
        gamesCount <- map["games_count"]
        imageBackground <- map["image_background"]
    }
}
