//
//  ProfileViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCircle(imageView: imageView)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
