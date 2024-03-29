//
//  FeedCell.swift
//  InstaCloneFirebase
//
//  Created by Fırat AKBULUT on 20.10.2023.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var documentIdLabel: UILabel!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButton(_ sender: UIButton) {
        let fireStoreDatabase = Firestore.firestore()
                
                if let likeCount = Int(likeLabel.text!) {
                    
                    let likeStore = ["likes" : likeCount + 1] as [String : Any]
                    
                    fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)

                }
    }
    
}
