
//
//  LoginVC.swift
//  
//
//  Created by Azi Azwady Jamaludin on 05/07/2017.
//
//

import UIKit

class LoginVC: MainVC_2 { //UIScrollViewDelegate
    
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var medImage: drawView!
    @IBOutlet weak var drawing: drawView!
    @IBOutlet weak var blackColorPencil: UIButton!
    @IBOutlet weak var greyColorPencil: UIButton!
    @IBOutlet weak var redColorPencil: UIButton!
    @IBOutlet weak var darkblueColorPencil: UIButton!
    @IBOutlet weak var lightblueColorPencil: UIButton!
    @IBOutlet weak var darkgreenColorPencil: UIButton!
    @IBOutlet weak var lightgreenColorPencil: UIButton!
    @IBOutlet weak var brownColorPencil: UIButton!
    @IBOutlet weak var orangeColorPencil: UIButton!
    @IBOutlet weak var yellowColorPencil: UIButton!
    @IBOutlet weak var eraser: UIButton!
    @IBOutlet weak var addText: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var closeAnnotation: UIButton!
   
    
    var opacity: CGFloat = 1.0
    
    
    let scale:CGFloat = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        patientName.isHidden = true
        
        hidePallete()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func hidePallete() {
        blackColorPencil.isHidden = true
        greyColorPencil.isHidden = true
        redColorPencil.isHidden = true
        darkblueColorPencil.isHidden = true
        lightblueColorPencil.isHidden = true
        darkgreenColorPencil.isHidden = true
        lightgreenColorPencil.isHidden = true
        brownColorPencil.isHidden = true
        orangeColorPencil.isHidden = true
        yellowColorPencil.isHidden = true
        eraser.isHidden = true
        //drawing.isHidden = true
        addText.isHidden = true
        reset.isHidden = true
        closeAnnotation.isHidden = true
    }
    
    func showPallete() {
        blackColorPencil.isHidden = false
        greyColorPencil.isHidden = false
        redColorPencil.isHidden = false
        darkblueColorPencil.isHidden = false
        lightblueColorPencil.isHidden = false
        darkgreenColorPencil.isHidden = false
        lightgreenColorPencil.isHidden = false
        brownColorPencil.isHidden = false
        orangeColorPencil.isHidden = false
        yellowColorPencil.isHidden = false
        eraser.isHidden = false
        //drawing.isHidden = false
        addText.isHidden = true
        reset.isHidden = true
        closeAnnotation.isHidden = false
    }
    
    @IBAction func annotationBarButton(_ sender: Any) {
        showPallete()
        drawing.editMode = ImageEditModes.editModeDrawing
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (drawing.isHidden == false) {
            drawing.drawBegan(touches, with: event!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (drawing.isHidden == false) {
        drawing.drawMoved(touches, with: event!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (drawing.isHidden == false) {
            drawing.drawEnded(touches, with: event!)
            mergeImage()
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(login, animated: true, completion: nil)
        login.showPallete()
        login.drawing.editMode = ImageEditModes.editModeDrawing
    }
    
    @IBAction func closeButton(_ sender: Any) {
        hidePallete()
    }
    
    @IBAction func downloadBarButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Action", preferredStyle: UIAlertController.Style.actionSheet)
        let downloadAction = UIAlertAction(title: "Download Image", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
            self.toImageListVC()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Download Cancel")
        })
        optionMenu.addAction(downloadAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func uploadBarButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Action", preferredStyle: UIAlertController.Style.actionSheet)
        let uploadAction = UIAlertAction(title: "Upload Image", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
            self.notIntegrateYet()
            print("Uploading...")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Upload Cancel")
        })
        optionMenu.addAction(uploadAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func shareBarButton(_ sender: Any) {
        displayShareSheet(shareContent: medImage.image!)
    }
    
    func displayShareSheet(shareContent:UIImage) {
        let shareActivity = UIActivityViewController(activityItems: [shareContent as UIImage], applicationActivities: nil)
        self.present(shareActivity, animated: true, completion: {})
    }

    
    @IBAction func homeBarButton(_ sender: AnyObject) {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let tab = sb.instantiateViewController(withIdentifier: "tabVC") as! UITabBarController
        self.present(tab, animated: true, completion: nil)
    }

    @IBAction func selectPalette(_ sender: AnyObject) {
        let index = sender.tag ?? 0
        drawing?.selectColor(mySender: sender)
        if index == 10 {
            let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
            let login = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.present(login, animated: true, completion: nil)
            login.showPallete()
            login.drawing.editMode = ImageEditModes.editModeDrawing
        }
    }
    
    @IBAction func addText(_ sender: Any) {
        /*drawing.textToImage()
        drawing.editMode = ImageEditModes.editModeText*/
        toBeUpdated()
    }
    
    func notIntegrateYet() {
        let info = "Apps not yet integrate"
        let infoAlert = UIAlertController(title: "PADI-MIM app", message: info , preferredStyle: UIAlertController.Style.alert)
        let infoAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
            let sb = UIStoryboard (name: "PADI-MIM", bundle: nil)
            _ = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        })
        infoAlert.addAction(infoAction)
        self.present(infoAlert, animated: true, completion: nil)
    }
    
    func toBeUpdated() {
        let info = "function to be updated"
        let infoAlert = UIAlertController(title: "PADI-MIM app", message: info , preferredStyle: UIAlertController.Style.alert)
        let infoAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
            let sb = UIStoryboard (name: "PADI-MIM", bundle: nil)
            _ = sb.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        })
        infoAlert.addAction(infoAction)
        self.present(infoAlert, animated: true, completion: nil)
    }
    
    func toImageListVC() {
        let sb = UIStoryboard(name: "PADI-MIM", bundle: nil)
        let imageListNav = sb.instantiateViewController(withIdentifier: "imageListNav") as! UINavigationController
        self.present(imageListNav, animated: true, completion: nil)
    }
    
    func mergeImage() {
        UIGraphicsBeginImageContext(drawing.frame.size)
        medImage.image?.draw(in: CGRect(x: 0, y: 0, width: medImage.frame.size.width, height: medImage.frame.size.height), blendMode: CGBlendMode.normal, alpha:opacity)
        drawing.image?.draw(in: CGRect(x: 0, y: 0, width: drawing.frame.size.width, height: medImage.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        medImage.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        drawing.image = nil
    }
    
    
}

    //}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



