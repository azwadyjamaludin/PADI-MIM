//
//  DicomTag.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 01/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import Foundation

struct DicomTag {
    var patientName: String
    var patientID: String
    var id:String
    var className = "DicomTag"
    
    init(patientName:String,patientID: String,id:String) {
       self.patientName = patientName
        self.patientID = patientID
        self.id = id
        
        /*if id.isEmpty {
            return nil
        }*/
    }
}
