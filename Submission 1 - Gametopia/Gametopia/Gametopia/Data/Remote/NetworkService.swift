//
//  NetworkService.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkService {
    
    // MARK: Gunakan API Key dalam akun Anda.
    let apiKey = "e99fe74e633e4257a3498d8af7d27560"
    let orderByRatingDesc = "-rating"
    let page = "1"
    
    func getDiscoveryGame(completionHandler: @escaping (GameResponse?) -> ()) {
        AF.request(
            "https://api.rawg.io/api/games",
            method: .get,
            parameters: ["key": apiKey, "ordering": orderByRatingDesc, "page_size": "10"],
            encoder: URLEncodedFormParameterEncoder.default
        ).response { resp in
            switch resp.result {
                case .success(_):
                    // Convert JSON String to Model
                    if let data = resp.data {
                        let jsonString = String(data: data, encoding: .utf8)
                        let discoveryResponse = Mapper<GameResponse>().map(JSONObject: jsonString?.toJSON())
                        completionHandler(discoveryResponse)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getListGenres(completionHandler: @escaping (GenreResponse?) -> ()) {
        AF.request(
            "https://api.rawg.io/api/genres",
            method: .get,
            parameters: ["key": apiKey],
            encoder: URLEncodedFormParameterEncoder.default
        ).response { resp in
            switch resp.result {
                case .success(_):
                    // Convert JSON String to Model
                    if let data = resp.data {
                        let jsonString = String(data: data, encoding: .utf8)
                        let listGenre = Mapper<GenreResponse>().map(JSONObject: jsonString?.toJSON())
                        completionHandler(listGenre)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getListDevelopers(completionHandler: @escaping (DeveloperResponse?) -> ()) {
        AF.request(
            "https://api.rawg.io/api/developers",
            method: .get,
            parameters: ["key": apiKey],
            encoder: URLEncodedFormParameterEncoder.default
        ).response { resp in
            switch resp.result {
                case .success(_):
                    // Convert JSON String to Model
                    if let data = resp.data {
                        let jsonString = String(data: data, encoding: .utf8)
                        let listDeveloper = Mapper<DeveloperResponse>().map(JSONObject: jsonString?.toJSON())
                        completionHandler(listDeveloper)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getSearchResults(keyword: String, completionHandler: @escaping (SearchResponse?) -> ()) {
        AF.request(
            "https://api.rawg.io/api/games",
            method: .get,
            parameters: ["key": apiKey, "search": keyword],
            encoder: URLEncodedFormParameterEncoder.default
        ).response { resp in
            switch resp.result {
                case .success(_):
                    // Convert JSON String to Model
                    if let data = resp.data {
                        let jsonString = String(data: data, encoding: .utf8)
                        let listResult = Mapper<SearchResponse>().map(JSONObject: jsonString?.toJSON())
                        completionHandler(listResult)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func getGameDetails(id: Int, completionHandler: @escaping (DetailGameResponse?) -> ()) {
        AF.request(
            "https://api.rawg.io/api/games/\(id)",
            method: .get,
            parameters: ["key": apiKey],
            encoder: URLEncodedFormParameterEncoder.default
        ).response { resp in
            switch resp.result {
                case .success(_):
                    // Convert JSON String to Model
                    if let data = resp.data {
                        let jsonString = String(data: data, encoding: .utf8)
                        let listResult = Mapper<DetailGameResponse>().map(JSONObject: jsonString?.toJSON())
                        completionHandler(listResult)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
