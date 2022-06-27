//
//  ImageListL2VCViewController.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 03/05/2019.
//  Copyright © 2019 Azi Azwady Jamaludin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ImageListL2VC: MainVC, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var patientDetTV: UITableView!
    @IBOutlet weak var dcmProgress: UIProgressView!
    
    var patientID = ""
    var downloadTask = URLSessionDownloadTask()
    var backgroundSession = URLSession()
    var dcmImgs:[UIImage] = []
    
    
    
    private var tagsL2 = [DicomTagL2]()
    private var images = [DIcomImage]()
    private var jsonMgr = JSONMgr()
    private var patientNameNavItem = ""
    private var patientIDL2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dcmProgress.isHidden = true
        patientDetTV.rowHeight = 388
        fetchTagsL2(patientID:patientID)
        // Do any additional setup after loading the view.
    }
    
    func  numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagsL2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listL2Cell = tableView.dequeueReusableCell(withIdentifier: "listCellL2") as! ImageListL2ViewCell
        let model:DicomTagL2
        model = tagsL2[indexPath.row]
        patientNameNavItem = model.patientName
        patientIDL2 = model.id
        
        listL2Cell.pnttext.text = model.patientName
        listL2Cell.pidtext.text = model.patientID
        listL2Cell.sextext.text = model.sex
        
        let dfGet = DateFormatter()
        dfGet.dateFormat = "yyyyMMdd"
        let dfOut = DateFormatter()
        dfOut.dateFormat = "dd/MM/yyyy"
        if let date:Date = dfGet.date(from: model.DOB) {
            listL2Cell.dobtext.text = dfOut.string(from: date)
        }else {
            print("There was an error decoding the string")
        }
        if let date:Date = dfGet.date(from: model.studyDate) {
            listL2Cell.sdttext.text = dfOut.string(from: date)
        }else {
            print("There was an error decoding the string")
        }
        
        listL2Cell.snttext.text = model.studyName
        listL2Cell.instext.text = model.institution
        listL2Cell.acntext.text = model.accessNumber
        
        return listL2Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(patientIDL2)
            fetchImage(parentIDL2: patientIDL2)
        }
    
    func fetchTagsL2 (patientID:String) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: self.jsonMgr.getTagL2(patientID: patientID))!
        
        Alamofire.request(url,method:.get)
            .validate()
            .responseJSON{response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags level 2: \(String(describing: response.result.error))")
                        return
                }
                
                let jsonValue = JSON(value)["dicomTagL2"].array?.map { json in
                    let tagL2 = DicomTagL2(patientName: json["patientName"].stringValue, patientID: json["patientID"].stringValue, DOB: json["DOB"].stringValue, sex: json["sex"].stringValue, studyDate: json["studyDate"].stringValue, studyName: json["studyName"].stringValue, institution: json["institution"].stringValue, accessNumber: json["accessNumber"].stringValue, id:json["id"].stringValue)
                    self.tagsL2.append(tagL2)
                }
                print(jsonValue!)
                DispatchQueue.main.async {
                    self.patientDetTV.reloadData()
                }
            }
        }
    }
    
    func fetchImage(parentIDL2:String) {
        dcmProgress.isHidden = false
        dcmProgress.setProgress(0, animated: false)
        DispatchQueue.global(qos:.background).async {
            let url = URL(string: self.jsonMgr.getImage(patientIDL2: parentIDL2))!
            
            Alamofire.request(url,method: .get)
                .validate()
                .downloadProgress{progress in
                    self.dcmProgress.setProgress(Float(CGFloat(progress.fractionCompleted * 100)), animated:true)
                }
                .responseJSON{response in
                    guard response.result.isSuccess,
                        let value = response.result.value else {
                            print("Error while fetching images: \(String(describing: response.result.error))")
                            return
                    }
                    
                    let jsonValue = JSON(value)["dicomImage"].array?.map { json in
                        let dcmItem = DIcomImage(uuid:json["uuid"].stringValue,stringUrl:json["url"].stringValue)
                        self.images.append(dcmItem)
                    }
                    print(jsonValue!)
                    /*if self.images.count > 0 {
                        for item in self.images {
                            let download = DicomDownload(filename: item.uuid+".dcm",downloadImage: self.getDICOMImage(stringURL: item.stringUrl)!)
                                self.dcmImgs.append(download.downloadImage)
                        }
                    }*/
                    
                        DispatchQueue.main.async {
                        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
                        let loginVC = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                        loginVC.imgFlag = true
                        //loginVC.dcmImgs = self.dcmImgs
                        loginVC.images = self.images
                        loginVC.navItemTitle = self.patientNameNavItem
                        print(self.patientNameNavItem)
                            
                        self.present(loginVC, animated: true, completion: nil)
                    }
                }
            }
        }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

/*if FileManager().fileExists(atPath: destination.path) {
 print("The file already exists at path")
 do {
 try FileManager.default.removeItem(atPath: destination.path)
 }catch {
 print("An error occurred while remove file from destination url")
 }
 }*/



