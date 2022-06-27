//
//  tempImgView.swift
//  PADI-MIM
//
//  Created by Azi Azwady Jamaludin on 01/11/2017.
//  Copyright © 2017 UTM. All rights reserved.
//

import UIKit

enum ImageEditModes:Int {
    case editModeDrawing
    case editModeText
}

class drawView: UIImageView, UITextViewDelegate {
    var viewInputText: UIView!
    var txtCorrection: UITextView!
    var editMode:ImageEditModes?
    var lastPoint = CGPoint.zero
    var red: CGFloat = 1.0
    var green: CGFloat = 1.0
    var blue: CGFloat = 0.0
    //var myalpha: CGFloat = 0.0
    var brushWidth: CGFloat = 4.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    //var medImage: UIImage!
    let scale:CGFloat = 0
    let colors: [(CGFloat, CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0,1),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0, 1),
        (1.0, 0, 0, 1),
        (0, 0, 1.0, 1),
        (51.0 / 255.0, 204.0 / 255.0, 1.0, 1),
        (102.0 / 255.0, 204.0 / 255.0, 0, 1),
        (102.0 / 255.0, 1.0, 0, 1),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0, 1),
        (1.0, 102.0 / 255.0, 0, 1),
        (1.0, 1.0, 0, 1),
        (0, 0.0, 0.0, 0),
        ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func drawBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode == ImageEditModes.editModeDrawing {
            swiped = false
            //store the first point where clicked
            if let touch = touches.first {
                lastPoint = touch.location(in: self)
                print("drawing mode lastPoint\(lastPoint)")
            }
            else if editMode == ImageEditModes.editModeText {
                if let touch = touches.first  {
                    lastPoint = touch.location(in: self)
                    print("text mode lastPoint\(lastPoint)")
                }
                viewInputText.frame = CGRect(x:lastPoint.x, y:lastPoint.y, width:viewInputText.frame.size.width, height:viewInputText.frame.size.height)
                txtCorrection.becomeFirstResponder()
            }
        }
    }
    
    func drawMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode == ImageEditModes.editModeDrawing {
            swiped = true
            
            // Draw a line in the image and display it
        if let touch =  touches.first {
                let currentPoint = touch.location(in: self)
                print("drawing mode currentPoint\(currentPoint)")
                drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
                print("drawing mode lastPoint\(lastPoint)")
            }
        }
    }
    
    func drawEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode == ImageEditModes.editModeDrawing {
            if !swiped {
                drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
            }
        }/*else if editMode == ImageEditModes.editModeText {
            textToImage()
        }*/
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
            UIGraphicsBeginImageContext(self.frame.size)
            //tempImage.draw(in: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            
            let context = UIGraphicsGetCurrentContext()
            self.image?.draw(in: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            context!.move(to: fromPoint)
            context!.addLine(to: toPoint)
            
            context!.setLineCap(CGLineCap.round)
            context!.setLineWidth(brushWidth)
            context!.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            context!.setBlendMode(CGBlendMode.normal)
            context!.strokePath()
            print("context = \(context!)")
            
            self.image = UIGraphicsGetImageFromCurrentImageContext()
            self.alpha = opacity
            UIGraphicsEndImageContext()
    }
    
    func selectColor(mySender: AnyObject) {
        var index = mySender.tag ?? 0
        print(index)
        
        if index < 0 || index >= colors.count {
            index = 0
        }
        (red, green, blue, alpha) = colors[index]
        print(colors[index])
        
        if index == colors.count - 1 {
            opacity = 1.0
        }
    }
    
    func textToImage(){
        viewInputText = UIView(frame:CGRect(x:0, y:0, width:33, height:40))
        viewInputText.backgroundColor = UIColor.gray
        txtCorrection = UITextView(frame:CGRect(x:5,y:5,width:23,height:30) )
        txtCorrection.delegate = self
        txtCorrection.font = UIFont.systemFont(ofSize: 10.0)
        txtCorrection.textColor = UIColor.yellow
        txtCorrection.backgroundColor = UIColor.clear
        
        viewInputText.addSubview(txtCorrection)
        self.addSubview(viewInputText)
        
        UIGraphicsBeginImageContextWithOptions(viewInputText.bounds.size, true, 0)
        viewInputText.drawHierarchy(in: viewInputText.bounds, afterScreenUpdates: true)
        
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)
        self.image?.draw(in: CGRect(x: 0, y: 0,width: self.frame.size.width, height: self.frame.size.height))
        
        imageWithText?.draw(in: viewInputText.frame)
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
