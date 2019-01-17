//
//  InitData.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 26/10/2017.
//  Copyright © 2017 UTM. All rights reserved.
//

import Foundation

class InitData {
    var initClass: String!
    var webServiceURL: String!
    let userDefaults = UserDefaults.standard
    
    init() {
        initClass = "This class manage the data from web"
        /*UserDefaults.standard.register(defaults: [String : Any]())
        webServiceURL = userDefaults.string(forKey: "url_preference")*/ //-Register at VC
    }
}
