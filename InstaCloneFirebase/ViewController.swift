//
//  ViewController.swift
//  InstaCloneFirebase
//
//  Created by Fırat AKBULUT on 18.10.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // firebase kullanıcı hatırlama viewdidload içerinde çalışmazsa SceneDelegate willConnectTo içine kod bloğu taşıyabilirsin.
//        if Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: "toFeedVc", sender: self)
//        }
    }
    
    @IBAction func logInClicked(_ sender: UIButton) {
        
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.makeAlert(title: "Error", message: e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toFeedVc", sender: self)
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


