//
//  ViewController2.swift
//  AccountApp
//
//  Created by 김희진 on 2021/07/16.
//

import UIKit

class ViewController2: UIViewController {
    
    
    //?는 값이 없을 수 있다는 뜻
    var isZoom = false
    var imgOn: UIImage?
    var imgOff:  UIImage?
    
    
    @IBOutlet var lblHello: UILabel!
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imgOn = UIImage(named: "2.png")
        imgOff = UIImage(named: "1.png")
        
        imgView.image = imgOn
        
    }
    
    
    
    @IBAction func btnResizeImage(_ sender: UIButton) {
    
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
    
        if(isZoom){
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale

            btnResize.setTitle("확대", for: .normal)
            print("ok1", newWidth, newHeight)
        }
        else{
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale

            btnResize.setTitle("축소", for: .normal)
            print("ok2", newWidth, newHeight)
        }

        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    
    
    
    @IBAction func btnSend(_ sender: UIButton) {
        
        lblHello.text = "Hello," + txtName.text!
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        
        if sender.isOn{
            imgView.image = imgOn
        }else{
            imgView.image = imgOff
        }
        
    }
    
}
