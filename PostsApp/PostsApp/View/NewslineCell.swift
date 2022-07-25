//
//  newslineCell.swift
//  PostsApp
//
//  Created by Андрей on 20.07.2022.
//

import UIKit

class NewslineCell: UITableViewCell {
    
    static let identifier = "newslineCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dayOfPublicationLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var onButtonClick: ((UIButton)->())!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        expandButton.layer.cornerRadius = 10
    }
    
    @IBAction func expandButtonPressed(_ sender: UIButton) {
        onButtonClick(sender)
    }
    
    func updateButtonTitle(expandStatus: Bool) {
        if expandStatus {
            expandButton.setTitle("Expand", for: .normal)
        } else {
            expandButton.setTitle("Collapse", for: .normal)
        }
    }
}
