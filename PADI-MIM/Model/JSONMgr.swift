//
//  JsonDummies.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 02/09/2018.
//  Copyright © 2018 UTM. All rights reserved.
//

import Foundation

class JSONMgr{
    var initClass: String!
    
    var webServiceURL: String!
    var offline: Bool!
    
    
    
    init() {
        initClass = "This class manage the JSON data from web"
        //registerSettingBundle()
    }
    
    /*func fetchTags () {
        let url = URL(string: getTag())!
        
        Alamofire.request(url,method:.get)
            .validate()
            .responseJSON{response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags: \(String(describing: response.result.error))")
                        return
                }
                
                let jsonValue = JSON(value)["dicomTag"].array?.map { json in
                    DicomTag(patientName: json["patientName"].stringValue, patientID: json["patientID"].stringValue, id: json["id"].stringValue)
                }
                print(jsonValue!)
        }
    } //completion:@escaping ([DicomTag]?) ->Void
    
    func fetchTagsL2 (parentID:String) {
        let url = URL(string: getTagL2())!
        
        Alamofire.request(url,method:.get,parameters: ["id":parentID])
            .validate()
            .responseJSON{response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags level 2: \(String(describing: response.result.error))")
                        return
                }
                
                let jsonValue = JSON(value)["dicomTagL2"].array?.map { json in
                    DicomTagL2(patientName: json["patientName"].stringValue, patientID: json["patientID"].stringValue, DOB: json["DOB"].stringValue, sex: json["sex"].stringValue, studyDate: json["studyDate"].stringValue, studyName: json["studyName"].stringValue, institution: json["institution"].stringValue, accessNumber: json["accessNumber"].stringValue, id:json["id"].stringValue)
                }
                
               print(jsonValue!)
        }
    }//,completion:@escaping ([DicomTagL2]?) ->Void
    
    func fetchImage (parentIDL2:String) {
        let url = URL(string: getImage())!
        
        Alamofire.request(url,method: .get,parameters: ["id":parentIDL2])
        .validate()
            .responseJSON{response in
                guard response.result.isSuccess,
                    let value = response.result.value
                
                    else {
                        print("Error while fetching images: \(String(describing: response.result.error))")
                        return
                }
                
                let jsonValue = JSON(value)["dicomImage"].array?.map { json in
                    let image = DIcomImage(uuid:json["uuid"].stringValue,base64String:json["encode"].stringValue)
                    
                }
                print(jsonValue!)
            }
        }//,completion:@escaping ([DIcomImage]?) -> Void
    */
    func registerSettingBundle() {
        let userDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: userDefaults)
        UserDefaults.standard.synchronize()
        
    }
    
    func getTag() -> String {
        let defaults = UserDefaults.standard
        webServiceURL = defaults.string(forKey: "url_preference")
        print(webServiceURL)
        return "https://"+"macbookpro.my/WLS"+"/WebService/resources/padimim/getTag"
    }
    
    func getTagL2(patientID:String) -> String {
        let defaults = UserDefaults.standard
        webServiceURL = defaults.string(forKey: "url_preference")
        print(webServiceURL)
        return "https://"+"macbookpro.my/WLS"+"/WebService/resources/padimim/getTagL2?id="+patientID
    }
    
    func getImage(patientIDL2:String) -> String {
        let defaults = UserDefaults.standard
        webServiceURL = defaults.string(forKey: "url_preference")
        print(webServiceURL)
        return "https://"+"macbookpro.my/WLS"+"/WebService/resources/padimim/getContent?id="+patientIDL2
    }
    
    func offLineMode() -> Bool {
         let defaults = UserDefaults.standard
        offline = defaults.bool(forKey: "off")
        print(offline)
        return offline
    }
}
