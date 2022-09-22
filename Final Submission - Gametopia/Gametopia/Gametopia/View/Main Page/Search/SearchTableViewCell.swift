//
//  SearchTableViewCell.swift
//  Gametopia
//
//  Created by Patricia Fiona on 13/09/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var score: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let contentViewColor = contentView.backgroundColor
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = contentViewColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }

}
