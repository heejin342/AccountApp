//
//  ViewController5.swift
//  AccountApp
//
//  Created by 김희진 on 2021/07/19.
//

import UIKit

class ViewController6: UIViewController {

    @IBOutlet weak var lblOutput: UILabel!
    
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    
    }
    
    var result : String? = "DEFUALT"
    
    override func viewDidLoad() {
        
        print("viewDidLoad21212")

        super.viewDidLoad()

        
        lblOutput.text = result
        
        print("viewDidLoad2")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear2")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear2")

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear2")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear2")

    }



}
