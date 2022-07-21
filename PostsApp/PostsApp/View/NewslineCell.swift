//
//  newslineCell.swift
//  PostsApp
//
//  Created by Андрей on 20.07.2022.
//

import UIKit

protocol TableViewCellDelegate {
    func clickButtonOnCell(index: Int)
}

class NewslineCell: UITableViewCell {
    
    static let shared = NewslineCell()
    
    var cellDelegate: TableViewCellDelegate?
    var index: IndexPath?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dayOfPublicationLabel: UILabel!
    
    @IBOutlet weak var expandButton: UIButton!
    
    var subTitleLabelIsOpen = false {
        didSet {
            if subTitleLabelIsOpen == false {
                subTitleLabel.numberOfLines = 2
            } else {
                subTitleLabel.numberOfLines = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subTitleLabel.numberOfLines = 2
        expandButton.layer.cornerRadius = 10
    }
    
    @IBAction func expandButtonPressed(_ sender: UIButton) {
        
        cellDelegate?.clickButtonOnCell(index: (index?.row)!)
        
    }
    
    
}
