//
//  welcomeScreen.swift
//  interface
//
//  Created by Ankita Vaid on 9/3/17.
//  Copyright © 2017 Ankita Vaid. All rights reserved.
//

import Foundation
import UIKit

class welcomeScreen: UIViewController {
    
    @IBOutlet var loginOptions: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var details = ["Register", "Login", "Continue As Guest"]
        for index in 0...(loginOptions.count - 1) {
            loginOptions[index].setTitle(details[index], for: .normal)
            loginOptions[index].layer.borderWidth = 1
            loginOptions[index].layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @IBAction func moveToMap(_ sender: UIButton) {
        self.performSegue(withIdentifier: "moveToMap", sender: nil)
    }
}
