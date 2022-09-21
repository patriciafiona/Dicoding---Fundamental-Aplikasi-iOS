//
//  ProfileViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userProfession: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCircle(imageView: imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProfileModel.synchronize()
        if ProfileModel.name.isEmpty && ProfileModel.email.isEmpty &&
            ProfileModel.location.isEmpty && ProfileModel.profession.isEmpty {
            setDefaultProfil()
        }
        
        setUserData()
    }
    
    private func setUserData(){
        userName.text = ProfileModel.name
        userId.text = ProfileModel.email
        userLocation.text = ProfileModel.location
        userProfession.text = ProfileModel.profession
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setDefaultProfil() {
        ProfileModel.stateLogin = true
        ProfileModel.name = "Patricia Fiona"
        ProfileModel.email = "patriciafiona3@gmail.com"
        ProfileModel.profession = "iOS & Android Enthusiasm"
        ProfileModel.location = "Jakarta, Jakarta, Indonesia"
    }
}
