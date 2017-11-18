//
//  ViewController.swift
//  interface

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Open.target = self.revealViewController()
        Open.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        

            //option.tag = 0
            //option.layer.borderWidth = 1
            //option.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//        if(sender.tag != 1) {
//            var change = sender.frame.origin.x - 10
//            sender.frame.origin.x = change
//            for option in menuOptions {
//                if(option.tag == 1) {
//                    var change = option.frame.origin.x + 10
//                    option.frame.origin.x = change
//                    option.tag = 0
//                }
//            }
//            sender.tag = 1
//        }
    


}

