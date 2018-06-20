//
//  ViewController.swift
//  interface
//
//  Created by Ankita Vaid on 9/3/17.
//  Copyright © 2017 Ankita Vaid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Open: UIBarButtonItem!
    
    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.userEmail.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    


}

