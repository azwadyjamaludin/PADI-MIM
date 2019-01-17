//
//  ImageListVC.swift
//  PADI_MIM
//
//  Created by Azi Azwady Jamaludin on 15/07/2017.
//  Copyright © 2017 Universiti Teknologi Malaysia. All rights reserved.
//

import UIKit

class ImageListVC: MainVC, UITableViewDataSource, UITableViewDelegate {
    @objc var imageID :NSMutableArray = []
    @objc var medicalImage: NSMutableArray = []
    @objc var selectedImageID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notIntegrateYet()
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
        return imageID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! ImageListViewCell
        
        let assignedImageID = imageID[indexPath.row]
        listCell.medImageID.text = assignedImageID as? String
        
        return listCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedImageID = imageID.object(at: indexPath.row) as? String
    }
    
    @IBAction func cancelDownload(_ sender: Any) {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(loginVC, animated: true, completion: nil)
    }
    
    func notIntegrateYet() {
        let info = "Apps not yet integrate"
        let infoAlert = UIAlertController(title: "PADI-MIM app", message: info , preferredStyle: UIAlertController.Style.alert)
        let infoAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
        let sb = UIStoryboard (name: "PADI-MIM", bundle: nil)
        _ = sb.instantiateViewController(withIdentifier: "ImageListVC") as! ImageListVC
        })
        infoAlert.addAction(infoAction)
        self.present(infoAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
