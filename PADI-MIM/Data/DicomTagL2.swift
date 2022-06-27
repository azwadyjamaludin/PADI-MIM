//
//  DicomTagL2.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 04/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import Foundation

struct DicomTagL2 {
    var patientName: String
    var patientID: String
    var DOB: String
    var sex: String
    var studyDate: String
    var studyName:String
    var institution:String
    var accessNumber:String
    var id:String
    var className = "DicomTagL2"
    
    init(patientName:String,patientID: String,DOB: String,sex: String,studyDate: String,studyName:String,institution:String,
    accessNumber:String,id:String) {
        self.patientName = patientName
        self.patientID = patientID
        self.DOB = DOB
        self.sex = sex
        self.studyDate = studyDate
        self.studyName = studyName
        self.institution = institution
        self.accessNumber = accessNumber
        self.id = id
        
        /*if id.isEmpty {
            return nil
        }*/
    }
}
