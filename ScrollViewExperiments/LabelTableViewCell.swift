//
//  ColorTableViewCell.swift
//  ScrollViewExperiments
//
//  Created by Yuichi Fujiki on 6/3/19.
//  Copyright © 2019 Yuichi Fujiki. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var contentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
