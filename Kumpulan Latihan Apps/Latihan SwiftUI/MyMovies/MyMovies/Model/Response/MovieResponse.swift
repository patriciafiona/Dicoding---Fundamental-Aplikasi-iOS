//
//  MovieResponse.swift
//  MyMovies
//
//  Created by Patricia Fiona on 21/09/22.
//

import Foundation

struct MovieResponse: Codable {
  let idMovie: Int
  let popularity: Double
  let title: String
  let genres: [Int]
  let voteAverage: Double
  let overview: String
  let releaseDate: Date
 
  let posterPath: URL
 
  enum CodingKeys: String, CodingKey {
    case idMovie = "id"
    case popularity
    case posterPath = "poster_path"
    case title
    case genres = "genre_ids"
    case voteAverage = "vote_average"
    case overview
    case releaseDate = "release_date"
  }
 
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
 
    // Menentukan alamat gambar
    let path = try container.decode(String.self, forKey: .posterPath)
    posterPath = URL(string: "https://image.tmdb.org/t/p/w300\(path)")!
 
    // Menentukan tanggal rilis
    let dateString = try container.decode(String.self, forKey: .releaseDate)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    releaseDate = dateFormatter.date(from: dateString)!
 
    // Untuk properti lainnya, cukup disesuaikan saja.
    idMovie = try container.decode(Int.self, forKey: .idMovie)
    popularity = try container.decode(Double.self, forKey: .popularity)
    title = try container.decode(String.self, forKey: .title)
    genres = try container.decode([Int].self, forKey: .genres)
    voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    overview = try container.decode(String.self, forKey: .overview)
  }
}
