//
//  ImageListVC.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 07/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ImageListVC: MainVC, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var patientTV: UITableView!
    
    private var tags = [DicomTag]()
    private var tagsL2 = [DicomTagL2]()
    private var jsonMgr = JSONMgr()

    var selectedID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonMgr.registerSettingBundle()
        fetchTags()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "listCell",for: indexPath) as! ImageListViewCell
        let model:DicomTag
        model = tags[indexPath.row]
        listCell.pnttext.text = model.patientName
        listCell.pidtext.text = model.patientID
        
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model:DicomTag
        model = tags[indexPath.row]
        selectedID = model.id
        print(selectedID)
        toImageListL2VC(parentID: selectedID)
    }
    
    @IBAction func cancelDownload(_ sender: Any) {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        //loginNav.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
    
    func fetchTags() {
        DispatchQueue.global(qos: .background).async {
            
            let url = URL(string: self.jsonMgr.getTag())!
            
            Alamofire.request(url,method:.get)
                .validate()
                .responseJSON{response in
                    guard response.result.isSuccess,
                        let value = response.result.value else {
                            print("Error while fetching tags: \(String(describing: response.result.error))")
                            return
                    }
                    
                    let jsonValue = JSON(value)["dicomTag"].array?.map { json in
                        let tag = DicomTag(patientName: json["patientName"].stringValue, patientID: json["patientID"].stringValue, id: json["id"].stringValue)
                        self.tags.append(tag)
                    }
                    print(jsonValue!)
                    DispatchQueue.main.async {
                        self.patientTV.reloadData()
                    }
                }
            }
        }
    
    func toImageListL2VC(parentID:String) {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let imageListL2VC = sb.instantiateViewController(withIdentifier: "ImageListL2VC") as! ImageListL2VC
        imageListL2VC.patientID = parentID
        self.navigationController?.pushViewController(imageListL2VC, animated: true)
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

