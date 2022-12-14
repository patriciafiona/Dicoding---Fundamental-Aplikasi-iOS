import UIKit

// MARK: Gunakan API Key dalam akun Anda.
let apiKey = "59ade0f2f439410860ac45335e2e539d"
let language = "en-US"
let page = "1"

var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!

components.queryItems = [
  URLQueryItem(name: "api_key", value: apiKey),
  URLQueryItem(name: "language", value: language),
  URLQueryItem(name: "page", value: page)
]

let request = URLRequest(url: components.url!)

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let response = response as? HTTPURLResponse else { return }

  if let data = data {
    if response.statusCode == 200 {
      print("DATA: \(data)")
    } else {
      print("ERROR: \(data), HTTPS Status: \(response.statusCode)")
    }
  }
}

task.resume()
