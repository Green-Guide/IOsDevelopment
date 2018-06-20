//Check database if emailText and passwordText match
//If they match move on to main screen

//Otherwise prompt user either email or password is incorrect and please try again

//Link from button instead of view controller, use shouldPerformSegue function

//Example login details: 
//User: airndham12@gmail.com
//Pass: password

//In case user wants to logout
//UserDefaults.standard.removeObject(forKey: "session")


import Foundation
import UIKit

class login: UIViewController {

    @IBOutlet weak var moveToMain: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userLoginMessage: UILabel!
    
    var successReference = "\"Login successful! Welcome back.\""
    
    var incorrectReference = "\"Incorrect user name and\\/or password.\""
    
    
    struct userDetails {
        static var isSuccess = false
        static var emailAddress = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.userLoginMessage.text! = ""
        self.moveToMain.setTitle("", for: .normal)
        self.moveToMain.isEnabled = false
        self.moveToMain.isHidden = true
    }
    
    
    @IBAction func loginRequest(_ sender: UIButton) {
        let postString = "email=\(emailText.text!)&password=\(passwordText.text!)&token_signup=06232017Job$"
        let urlString = "http://www.lovegreenguide.com/login_app.php"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            self.userLoginMessage.text = String(describing: responseString!)
            //print("responseString = \(String(describing: responseString!))")
            let message = String(describing: responseString!)
            if(message == self.successReference) {
                self.moveToMain.isEnabled = true
                self.moveToMain.isHidden = false
                self.moveToMain.setTitle("Return to Home Screen", for: .normal)
                userDetails.isSuccess = true
                userDetails.emailAddress = self.emailText.text!
                UserDefaults.standard.set("active", forKey: "session")
            }
        }
        task.resume()
    }
    
    
}

