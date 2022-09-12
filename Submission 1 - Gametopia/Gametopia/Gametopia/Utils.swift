//
//  Utils.swift
//  Gametopia
//
//  Created by Patricia Fiona on 11/09/22.
//

import Foundation
import UIKit

func imageCircle(imageView: UIImageView){
    imageView.layer.cornerRadius = imageView.frame.size.height / 2;
    imageView.layer.masksToBounds = true;
    imageView.layer.borderWidth = 0;
}

func viewRounded(view: AnyObject, radius: Int){
    view.layer.cornerRadius = CGFloat(radius);
    view.layer.masksToBounds = true;
    view.layer.borderWidth = 0;
}
