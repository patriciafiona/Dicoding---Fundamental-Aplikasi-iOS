//
//  MovieModel.swift
//  MyMovies
//
//  Created by Patricia Fiona on 21/09/22.
//

import Foundation

class Movie: Identifiable {
  let idMovie: Int
  let title: String
  let overview: String
  let posterPath: URL

  init(idMovie: Int, title: String, overview: String, posterPath: URL) {
    self.idMovie = idMovie
    self.title = title
    self.posterPath = posterPath
    self.overview = overview
  }
}

let movies = [
  Movie(
    idMovie: 0,
    title: "Thor: Love and Thunder",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg")!
  ), Movie(
    idMovie: 1,
    title: "Minions: The Rise of Gru",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/wKiOkZTN9lUUUNZLmtnwubZYONg.jpg")!
  ), Movie(
    idMovie: 2,
    title: "Jurassic World Dominion",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/kAVRgw7GgK1CfYEJq8ME6EvRIgU.jpg")!
  ), Movie(
    idMovie: 3,
    title: "Top Gun: Maverick",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/62HCnUTziyWcpDaBO2i1DX17ljH.jpg")!
  ), Movie(
    idMovie: 4,
    title: "The Gray Man",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/8cXbitsS6dWQ5gfMTZdorpAAzEH.jpg")!
  ), Movie(
    idMovie: 5,
    title: "The Black Phone",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/p9ZUzCyy9wRTDuuQexkQ78R2BgF.jpg")!
  ), Movie(
    idMovie: 6,
    title: "Lightyear",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/ox4goZd956BxqJH6iLwhWPL9ct4.jpg")!
  ), Movie(
    idMovie: 7,
    title: "Doctor Strange in the Multiverse of Madness",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/9Gtg2DzBhmYamXBS1hKAhiwbBKS.jpg")!
  ), Movie(
    idMovie: 8,
    title: "Indemnity",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/tVbO8EAbegVtVkrl8wNhzoxS84N.jpg")!
  ), Movie(
    idMovie: 9,
    title: "Borrego",
    overview: "",
    posterPath: URL(string: "https://image.tmdb.org/t/p/w500/kPzQtr5LTheO0mBodIeAXHgthYX.jpg")!
  )
]
