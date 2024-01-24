//
//  NewUserViewController.swift
//  InstaCloneFirebase
//
//  Created by Fırat AKBULUT on 19.10.2023.
//

import UIKit
import FirebaseAuth

class NewUserViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func registerClicked(_ sender: UIButton) {
        
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.makeAlert(title: "Error", message: e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "toFeedVc", sender: nil)
                }
            }
        }
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
