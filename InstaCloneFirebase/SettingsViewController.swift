//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Fırat AKBULUT on 18.10.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func logoutClicked(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        performSegue(withIdentifier: "toLogInVc", sender: nil)
    }
    
}
