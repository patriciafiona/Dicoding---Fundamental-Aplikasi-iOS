//
//  MovieResponses.swift
//  MyMovies
//
//  Created by Patricia Fiona on 21/09/22.
//

import Foundation

struct MovieResponses: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let movies: [MovieResponse]
 
  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movies = "results"
  }
}
