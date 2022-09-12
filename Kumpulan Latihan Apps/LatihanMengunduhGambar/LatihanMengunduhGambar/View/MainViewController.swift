//
//  ViewController.swift
//  LatihanMengunduhGambar
//
//  Created by Patricia Fiona on 09/09/22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
     
        movieTableView.register(
          UINib(nibName: "MovieTableViewCell", bundle: nil),
          forCellReuseIdentifier: "movieTableViewCell"
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task { await getMovies() }
      }
     
      func getMovies() async {
        let network = NetworkService()
        do {
          movies = try await network.getMovies()
          movieTableView.reloadData()
        } catch {
          fatalError("Error: connection failed.")
        }
    }
}
     
extension MainViewController: UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return movies.count
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(
      withIdentifier: "movieTableViewCell",
      for: indexPath
    ) as? MovieTableViewCell {

      let movie = movies[indexPath.row]
      cell.movieLabel.text = movie.title
      cell.movieImage.image = movie.image

      if movie.state == .new {
        cell.indicatorLoading.isHidden = false
        cell.indicatorLoading.startAnimating()
        startDownload(movie_data: movie, indexPath: indexPath)
      } else {
        cell.indicatorLoading.stopAnimating()
        cell.indicatorLoading.isHidden = true
      }

      return cell
    } else {
      return UITableViewCell()
    }
  }

  fileprivate func startDownload(movie_data: Movie, indexPath: IndexPath) {
    let imageDownloader = ImageDownloader()
    if movie_data.state == .new {
      Task {
        do {
          let image = try await imageDownloader.downloadImage(url: movie_data.posterPath)
            movies[indexPath.row].state = .downloaded
            movies[indexPath.row].image = image
          self.movieTableView.reloadRows(at: [indexPath], with: .automatic)
        } catch {
            movies[indexPath.row].state = .failed
            movies[indexPath.row].image = nil
        }
      }
    }
  }
}
