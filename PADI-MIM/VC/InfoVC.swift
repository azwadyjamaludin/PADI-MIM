//
//  SettingVC.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 08/02/2018.
//  Copyright © 2018 UTM. All rights reserved.
//

import UIKit

class InfoVC: MainVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        aboutApp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func aboutApp() {
        let aboutAppMessage1 = "Pan Asian Diagnostic Imaging (PADI) is a secure, cloud-based service that provides easily accessible for storing, sharing, and viewing medical imaging"
        let aboutAppMessage2 = "This application is made with the collaboration of 2 universities (University Putra Malaysia from Radiology department and University Technology Malaysia from Advanced Informatics School). The aim is to create a new platform in Malaysia's medical environment in sharing between department and hospital, medical conferences and the accessibility"
        let aboutAppMessage3 = "This application is aim to improve medical system in Malaysia in term of medical sharing and discussion hence improving the medical care quality"
        let aboutAppAlert = UIAlertController(title: "PADI-MIM app", message: aboutAppMessage1+"\n"+aboutAppMessage2+"\n"+aboutAppMessage3 , preferredStyle: UIAlertController.Style.alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
            let sb = UIStoryboard (name: "PADI-MIM", bundle: nil)
            let setting = sb.instantiateViewController(withIdentifier: "SettingNav") as! UINavigationController
            setting.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            //self.present(setting, animated: true, completion: nil)
        })
        aboutAppAlert.addAction(closeAction)
        self.present(aboutAppAlert, animated: true, completion: nil)
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
