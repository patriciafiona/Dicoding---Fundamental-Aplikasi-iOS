//
//  GenreCollectionViewCell.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewSkeletonTemp: UIImageView!
    @IBOutlet weak var darkTransparent: UIImageView!
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalGames: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with data: GenreResult){
        name.text = data.name
        totalGames.text = "Total games: \(data.gamesCount!)"
        
        if let backgroundImage = data.imageBackground{
            let url = URL(string: (backgroundImage))
            imageBackground.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder_image"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ]
            )
        }
    }

}
