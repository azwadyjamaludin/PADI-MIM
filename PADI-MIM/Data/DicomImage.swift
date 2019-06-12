//
//  DicomImage.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 07/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import Foundation

struct DIcomImage {
    var uuid = ""
    var stringUrl = ""
    var className = "DicomImage"
    
    init(uuid:String,stringUrl:String) {
        self.uuid = uuid
        self.stringUrl = stringUrl
        
    }
}
