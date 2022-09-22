//
//  ProfileViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 12/09/22.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var changePictureBtn: UIButton!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userProfession: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    private let imagePicker = UIImagePickerController()
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary

        imageCircle(imageView: imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProfileModel.synchronize()
        if ProfileModel.name.isEmpty && ProfileModel.email.isEmpty &&
            ProfileModel.location.isEmpty && ProfileModel.profession.isEmpty {
            setDefaultProfil()
        }
        
        //set image based on database
        if let profile = realm.object(ofType: UserProfile.self, forPrimaryKey: ProfileModel.email) {
            DispatchQueue.main.async {
                self.imageView.contentMode = .scaleToFill
                self.imageView.image = UIImage(data: profile.photo)
                self.imageView.setNeedsDisplay()
                
                imageCircle(imageView: self.imageView)
            }
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
    
    
    @IBAction func onChangePictureBtn(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            //save or update to Realm database
            self.imageView.contentMode = .scaleToFill
            self.imageView.image = result
            
            if realm.object(ofType: UserProfile.self, forPrimaryKey: ProfileModel.email) != nil {
                //update
                if let image = imageView.image, let data = image.pngData() as NSData? {
                    let profile = realm.objects(UserProfile.self).first!
                    
                    // Open a thread-safe transaction
                    try! realm.write {
                        profile.photo = data as Data
                    }
                }
            }else{
                //add
                if let image = imageView.image, let data = image.pngData() as NSData? {
                    let profile = UserProfile()
                    profile._id = ProfileModel.email
                    profile.photo = data as Data
                    
                    try! realm.write {
                        realm.add(profile)
                    }
                }
            }
            
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Failed", message: "Image can't be loaded.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
