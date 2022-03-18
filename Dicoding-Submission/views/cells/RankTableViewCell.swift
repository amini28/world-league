//
//  RankTableViewCell.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 18/06/21.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var klubname: UILabel!
    @IBOutlet weak var played: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet weak var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
