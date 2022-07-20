//
//  newslineCell.swift
//  PostsApp
//
//  Created by Андрей on 20.07.2022.
//

import UIKit

class newslineCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dayOfPublicationLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expandButton.layer.cornerRadius = 10
    }

    @IBAction func expandButtonPressed(_ sender: UIButton) {
    }
    

}
