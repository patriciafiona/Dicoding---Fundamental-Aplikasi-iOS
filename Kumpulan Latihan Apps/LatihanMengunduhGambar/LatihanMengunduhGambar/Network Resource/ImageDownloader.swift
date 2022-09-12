//
//  ImageDownloader.swift
//  LatihanMengunduhGambar
//
//  Created by Patricia Fiona on 10/09/22.
//

import Foundation
import SwiftUI

class ImageDownloader {
 
  func downloadImage(url: URL) async throws -> UIImage {
    async let imageData: Data = try Data(contentsOf: url)
    return UIImage(data: try await imageData)!
  }
}
