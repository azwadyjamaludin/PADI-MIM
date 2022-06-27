
//
//  LoginVC.swift
//  
//
//  Created by Azi Azwady Jamaludin on 05/07/2017.
//
//

import UIKit
import Alamofire

class LoginVC: MainVC { 
    
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
    @IBOutlet weak var saveDrawing: UIButton!
    @IBOutlet weak var closeAnnotation: UIButton!
    @IBOutlet weak var prevItem: UIBarButtonItem!
    @IBOutlet weak var startItem: UIBarButtonItem!
    @IBOutlet weak var startANIMItem: UIBarButtonItem!
    @IBOutlet weak var stopANIMItem: UIBarButtonItem!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var taskProgress: UIProgressView!
    
    
    var opacity: CGFloat = 1.0
    var imageIndex:Int = 0
    var imgFlag:Bool = false
    var navItemTitle = ""
    var utf8Image = ""
    var dcmImgs = [UIImage]()
    var images = [DIcomImage]()
    var dcmdownload = [DicomDownload]()
    
    let scale:CGFloat = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        patientName.isHidden = true
        hidePallete()
        taskProgress.isHidden = true
        
        if imgFlag == false {
            disablePlayer()
        } else if imgFlag == true {
            patientName.isHidden = false
            patientName.text = navItemTitle
            for item in images {
            fetchDICOMImage(stringURL: item.stringUrl)
                }
            //showPallete()
            }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func annotationBarButton(_ sender: Any) {
        showPallete()
        drawing.editMode = ImageEditModes.editModeDrawing
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if (self.drawing.isHidden == false) {
                self.drawing.drawBegan(touches, with: event!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (self.drawing.isHidden == false) {
                self.drawing.drawMoved(touches, with: event!)
            }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if (self.drawing.isHidden == false) {
                self.drawing.drawEnded(touches, with: event!)
            }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        hidePallete()
    }
    
    @IBAction func downloadBarButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Action", preferredStyle: UIAlertController.Style.actionSheet)
        let downloadAction = UIAlertAction(title: "Get Patients / Studies", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
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
    
    /*@IBAction func uploadBarButton(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Action", preferredStyle: UIAlertController.Style.actionSheet)
        let uploadAction = UIAlertAction(title: "Upload Image", style: UIAlertAction.Style.default, handler: {(alert:UIAlertAction) -> Void in
            for item in self.images {
            self.uploadImageToWeb(fileName:item.uuid )
            print("Uploading...")
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Upload Cancel")
        })
        optionMenu.addAction(uploadAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }*/
    
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
            drawing.image = nil
        }
    }
    
    @IBAction func saveImage(_ sender: Any) {
        mergeImage()
    }
    
    func notIntegrateYet() {
        let info = "Future Development Function"
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
        imageListNav.modalTransitionStyle = UIModalTransitionStyle.coverVertical
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
        saveDrawing.isHidden = true
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
        saveDrawing.isHidden = false
        closeAnnotation.isHidden = false
    }
    
    func disablePlayer() {
        self.prevItem.isEnabled = false
        self.startANIMItem.isEnabled = false
        self.stopANIMItem.isEnabled = false
        self.startItem.isEnabled = false
    }
    
    func enablePlayer() {
        self.prevItem.isEnabled = true
        self.startANIMItem.isEnabled = true
        self.stopANIMItem.isEnabled = true
        self.startItem.isEnabled = true
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resumeLayer(layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    @IBAction func startButton(_ sender: UIBarButtonItem) {
        if (medImage.layer.timeOffset == medImage.layer.convertTime(CACurrentMediaTime(), from: nil)) {
            medImage.stopAnimating()
            imageIndex+=1
            medImage.image = dcmImgs[imageIndex]
        }
        if imageIndex == dcmImgs.endIndex {
                imageIndex = dcmImgs.startIndex
                imageIndex+=1
                medImage.image = dcmImgs[imageIndex]
        }
       
       imageIndex = dcmImgs.lastIndex(of: medImage.image!)!
       imageIndex+=1
       medImage.image = dcmImgs[imageIndex]
       
    }
    
    @IBAction func startAnimate(_ sender: UIBarButtonItem) {
        if (medImage.layer.timeOffset == medImage.layer.convertTime(CACurrentMediaTime(), from: nil)) {
            self.resumeLayer(layer: medImage.layer)
        }else {
        medImage.animationImages = dcmImgs
        medImage.animationDuration = TimeInterval(dcmImgs.count)/2
        medImage.animationRepeatCount = 1
        medImage.startAnimating()
        }
    }
    
    
    @IBAction func pauseAnimte(_ sender: UIBarButtonItem) {
        pauseLayer(layer: medImage.layer)
    }
    
    @IBAction func prevButton(_ sender: UIBarButtonItem) {
        if (medImage.layer.timeOffset == medImage.layer.convertTime(CACurrentMediaTime(), from: nil)) {
            medImage.stopAnimating()
        }
        if (imageIndex == dcmImgs.startIndex) {
            imageIndex = dcmImgs.endIndex
            imageIndex -= 1
            medImage.image = dcmImgs[imageIndex]
        }
        
        imageIndex = dcmImgs.lastIndex(of: medImage.image!)!
        imageIndex -= 1
        medImage.image = dcmImgs[imageIndex]
        
    }


func fetchDICOMImage(stringURL:String) {
    //taskProgress.isHidden = false
    //taskProgress.setProgress(0, animated: false)
    if let dcmImageURL = URL(string: stringURL) {
        let docURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destination = docURL.appendingPathComponent(dcmImageURL.lastPathComponent)
        //print(destination)
        
        Alamofire.request(dcmImageURL)
            .validate()
            /*.downloadProgress{progress in
                self.taskProgress.setProgress(Float(CGFloat(progress.fractionCompleted * 100)), animated:true)
                
            }*/
            .responseData { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching images: \(String(describing: response.result.error))")
                        return
                }
                
                do {
                    try value.write(to: destination)
                    self.fetchImageFromDestination(path: destination.path)
                }catch {
                    print("File not exist at path\(destination.path)")
                }
        }
    }
}

func fetchImageFromDestination(path:String) {
 do{
    let filePath = path
    print(filePath)
    let dataSet = try ImebraCodecFactory.load(fromFile: filePath)
    //let endIndex = filePath.index(filePath.endIndex, offsetBy: -4)
    // patientNameCharacter
    _ = try dataSet.getString(ImebraTagId(group: 0x10, tag: 0x10), elementNumber: 0, defaultValue: "")
 
    // patientNameIdeographic
    _ = try dataSet.getString(ImebraTagId(group: 0x10, tag: 0x10), elementNumber: 1, defaultValue: "")
 
    let image = try dataSet.getImageApplyModalityTransform(0)
    let colorSpace = image.colorSpace
    let width = image.width
    let height = image.height
 
    let chain = Utils.applyTransformation(colorSpace: colorSpace,
                                          dataSet: dataSet,
                                          image: image,
                                          width: width,
                                          height: height)
    
    medImage.image = Utils.generateImage(chain: chain!, image: image)!
    let downloadItem = DicomDownload(downloadImage: medImage.image!)
    dcmdownload.append(downloadItem)
    
    for item in dcmdownload {
    dcmImgs.append(item.downloadImage)
    }
    medImage.image = dcmImgs[0]
    enablePlayer()
    //showPallete()
    //self.taskProgress.isHidden = true
    } catch {
        print("Something went wrong")
        }
    }
    
}
    /*func uploadImageToWeb(fileName:String) {
        taskProgress.isHidden = false
        taskProgress.setProgress(0, animated: false)
        
        let uploadURL = URL(string: "https://macbookpro.my/assets/DICOMupload")!
        
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        request.setValue("application/dicom", forHTTPHeaderField: "Content-Type")
        for item in dcmImgs {
        request.httpBody = try! JSONSerialization.data(withJSONObject:item,options: [])
        Alamofire.upload(multipartFormData: { (multipartFormData:MultipartFormData) in
            multipartFormData.append(request.httpBody!,withName: fileName,fileName: fileName+".dcm",mimeType: "application/dicom")
            },to: uploadURL,
            //headers: ["Authorization": "Basic xxx"],
             encodingCompletion: { encodingResult in
                switch encodingResult {
                    case .success(let upload, _, _):
                        upload.uploadProgress { progress in
                            self.taskProgress.setProgress(Float(CGFloat(progress.fractionCompleted * 100)), animated:true)
                        }
                        upload.validate()
                        upload.responseJSON { response in
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            })
        }
    }*/


/* Alamofire.request(request)
 .downloadProgress { progress in
 self.taskProgress.setProgress(Float(CGFloat(progress.fractionCompleted * 100)), animated:true)
 }
 .responseJSON {response in
 switch response.result {
 case .success(let responseObject):
 debugPrint(responseObject)
 
 case .failure(let error):
 print(error)
 }
 }
 */
