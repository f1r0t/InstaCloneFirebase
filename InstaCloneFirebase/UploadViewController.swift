//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Fırat AKBULUT on 18.10.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadButton.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func selectImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = pickedImage
            uploadButton.isUserInteractionEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func uploadClicked(_ sender: UIButton) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uniqueID = UUID().uuidString
            let imageRef = mediaFolder.child("\(uniqueID).jpeg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                
                if let e = error {
                    self.makeAlert(title: "Error!", message: e.localizedDescription)
                } else{
                    imageRef.downloadURL {(url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            
                            let db = Firestore.firestore()
                            var ref: DocumentReference? = nil
                            
                            if let imageUrl = imageUrl,let currentUserEmail = Auth.auth().currentUser?.email, let commentText = self.commentText.text {
                                let firePosts: [String: Any] = [
                                    "imageUrl": imageUrl,
                                    "postedBy": currentUserEmail,
                                    "postComment": commentText,
                                    "date": FieldValue.serverTimestamp(),
                                    "likes": 0
                                ]
                                
                                ref = db.collection("Posts").addDocument(data: firePosts, completion: { error in
                                    if let e = error {
                                        self.makeAlert(title: "Error!", message: e.localizedDescription)
                                    } else {
                                        self.tabBarController?.selectedIndex = 0
                                        self.imageView.image = UIImage(named: "select.png")
                                        self.commentText.text = ""
                                    }
                                })
                            } else {
                               
                                self.makeAlert(title: "Error!", message: "Missing required values.")
                            }
                            
                            
                        }
                    }
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

