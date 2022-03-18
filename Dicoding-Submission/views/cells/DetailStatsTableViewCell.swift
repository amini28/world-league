//
//  DetailStatsTableViewCell.swift
//  Dicoding-Submission
//
//  Created by Novriansyah Amini on 18/06/21.
//

import UIKit

class DetailStatsTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
