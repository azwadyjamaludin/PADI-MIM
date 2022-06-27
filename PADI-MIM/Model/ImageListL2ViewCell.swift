//
//  ImageListL2ViewCell.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 03/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import UIKit

class ImageListL2ViewCell: UITableViewCell {
    @IBOutlet weak var pnttext: UILabel!
    @IBOutlet weak var pidtext: UILabel!
    @IBOutlet weak var dobtext: UILabel!
    @IBOutlet weak var sextext: UILabel!
    @IBOutlet weak var sdttext: UILabel!
    @IBOutlet weak var snttext: UILabel!
    @IBOutlet weak var instext: UILabel!
    @IBOutlet weak var acntext: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
