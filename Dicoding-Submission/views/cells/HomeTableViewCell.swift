//
//  HomeTableViewCell.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 13/06/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
