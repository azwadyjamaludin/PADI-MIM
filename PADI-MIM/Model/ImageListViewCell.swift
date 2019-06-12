//
//  ImageListViewCell.swift
//  PADI_MIM
//
//  Created by Azi Azwady Jamaludin on 16/07/2017.
//  Copyright © 2017 Universiti Teknologi Malaysia. All rights reserved.
//

import UIKit

class ImageListViewCell: UITableViewCell {

    @IBOutlet weak var pnttext: UILabel!
    @IBOutlet weak var pidtext: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
