//
//  DicomDownload.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 24/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import Foundation

struct DicomDownload {
    var downloadImage = UIImage()
    var className = "DicomDownload"
    
    init(downloadImage:UIImage) {
        self.downloadImage = downloadImage
    }
}
