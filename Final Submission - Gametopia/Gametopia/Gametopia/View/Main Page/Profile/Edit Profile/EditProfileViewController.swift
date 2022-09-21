//
//  EditProfileViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 21/09/22.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var updateBtn: UIButton!
    
    @IBOutlet weak var editLocation: UITextField!
    @IBOutlet weak var editProfession: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ProfileModel.synchronize()
        editName.text = ProfileModel.name
        editEmail.text = ProfileModel.email
        editProfession.text = ProfileModel.profession
        editLocation.text = ProfileModel.location
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onUpdateBtnClicked(_ sender: Any) {
        if let name = editName.text, let email = editEmail.text,
           let profession = editProfession.text, let location = editLocation.text {
            if name.isEmpty {
                textEmpty("Name")
            } else if email.isEmpty {
                textEmpty("Email")
            } else if profession.isEmpty {
                textEmpty("Profession")
            } else if location.isEmpty {
                textEmpty("Location")
            } else {
                saveProfil(name, email, profession, location)
            }
        }
    }
    
    private func saveProfil(_ name: String, _ email: String, _ profession: String, _ location: String) {
        ProfileModel.stateLogin = true
        ProfileModel.name = name
        ProfileModel.email = email
        ProfileModel.profession = profession
        ProfileModel.location = location
        
        let alert = UIAlertController(title: "Update Profile", message: "Success update user profile", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)

        //directly back to user profile after 2 second
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onBackBtnClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func textEmpty(_ field: String) {
        let alert = UIAlertController(
            title: "Alert",
            message: "\(field) is empty",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
