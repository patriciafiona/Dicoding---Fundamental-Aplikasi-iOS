//
//  MovieTableViewCell.swift
//  LatihanMengunduhGambar
//
//  Created by Patricia Fiona on 09/09/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var indicatorLoading: UIActivityIndicatorView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
