//
//  ViewController3.swift
//  AccountApp
//
//  Created by 김희진 on 2021/07/17.
//


    
import UIKit

class ViewController3: UIViewController {

    var maxImage = 3
    var numImage = 1

    @IBOutlet var image: UIImageView!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()

        image.image = UIImage(named:"1")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func prev(_ sender: UIButton) {
        numImage = numImage - 1
        if (numImage < 1) {
            numImage = maxImage
        }
        
        let imageName = String(numImage) + ".png"
        image.image = UIImage(named:imageName)
        
    }
    
    @IBAction func next(_ sender: UIButton) {
        
        numImage = numImage + 1
        if (numImage > maxImage) {
            numImage = 1
        }
        
        let imageName = String(numImage) + ".png"
        image.image = UIImage(named:imageName)

    }
}
