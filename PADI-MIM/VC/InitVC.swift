//
//  launchVC.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 01/11/2017.
//  Copyright © 2017 UTM. All rights reserved.
//

import UIKit

class InitVC: MainVC {
    
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet weak var logoButton: UIButton!
    
    var delayTimer: Timer!
    var jsonMgr = JSONMgr()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoButton.isHidden = true
        touchLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         delayTimer = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(showLogo), userInfo: nil, repeats: true)
        delayTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(showLabel), userInfo: nil, repeats: true)
    }
    
    @objc func showLogo() {
        logoButton.isHidden = false
    }
    
    @objc func showLabel() {
        touchLabel.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterButton(_ sender: Any) {
        login()
    }
    
    func toLogin() {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(login, animated: true, completion: nil)
    }
    
    func wrongCred() {
        let wrongCredAlert = UIAlertController(title: "Wrong Credential", message: "", preferredStyle: .alert)
        let reEnterAction = UIAlertAction(title: "Try Again", style: .cancel, handler: {(alert:UIAlertAction) -> Void in
            wrongCredAlert.dismiss(animated: true, completion: nil)
            self.login()
        })
        wrongCredAlert.addAction(reEnterAction)
        self.present(wrongCredAlert, animated: true, completion: nil)
    }
    
    func login() {
    let credAlert = UIAlertController(title:"Enter Credential", message: nil, preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "Login", style: .default, handler: {(alert:UIAlertAction) -> Void in
        let userName = credAlert.textFields?[0].text
        let passWord = credAlert.textFields?[1].text
        
        if (userName == "usertest" && passWord == "passtest"){
            self.toLogin()
        }else {
            self.wrongCred()
        }
        
    })
    credAlert.addTextField{(userField) in
    userField.placeholder = "username"
    }
    credAlert.addTextField{(passField) in
    passField.placeholder = "password"
    passField.isSecureTextEntry = true
    }
    credAlert.addAction(confirmAction)
    self.present(credAlert, animated: true, completion: nil)
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
