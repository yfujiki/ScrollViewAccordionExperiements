//
//  ColorTableViewCell.swift
//  ScrollViewExperiments
//
//  Created by Yuichi Fujiki on 6/3/19.
//  Copyright © 2019 Yuichi Fujiki. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var colorImageView: UIImageView!

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
