//
//  DeveloperTableViewCell.swift
//  Gametopia
//
//  Created by Patricia Fiona on 13/09/22.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var darkTransparent: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var gameItemBtn01: UIButton!
    @IBOutlet weak var gameItemBtn02: UIButton!
    @IBOutlet weak var gameItemBtn03: UIButton!
    
    @IBOutlet weak var gameItemAdded01: UILabel!
    @IBOutlet weak var gameItemAdded02: UILabel!
    @IBOutlet weak var gameItemAdded03: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let contentViewColor = contentView.backgroundColor
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = contentViewColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
}
