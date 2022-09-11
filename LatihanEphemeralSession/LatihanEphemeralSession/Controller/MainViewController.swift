//
//  ViewController.swift
//  LatihanEphemeralSession
//
//  Created by Patricia Fiona on 10/09/22.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadImage()
    }

    private func downloadImage() {
        let path = "https://www.dicoding.com/blog/wp-content/uploads/2017/10/dicoding-logo-square.png"
        let url = URL(string: path)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)

        if let response = configuration.urlCache?.cachedResponse(for: URLRequest(url: url!)) {
          label.text = "Use cache image"
          imageView.image = UIImage(data: response.data)
        } else {
          label.text = "Call image from network"
          let downloadTask = session.dataTask(with: url!) { [weak self] data, response, error in
            guard let self = self, let data = data else { return }
            DispatchQueue.main.async {
              self.imageView.image = UIImage(data: data)
            }
          }
          downloadTask.resume()
        }
    }

}

