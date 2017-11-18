

import Foundation
import UIKit

class signUp: UIViewController {
    
    @IBOutlet var loginOptions: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorMessage.text = ""
    }
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func sendLoginInfo(_ sender: UIButton) {
        let postString = "email=\(email.text!)&password=\(password.text!)&token_signup=06232017Job$"
        var request = URLRequest(url: URL(string: "http://www.lovegreenguide.com/login_app.php")!)
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
            print("responseString = \(String(describing: responseString!))")
            let responseMessage = String(describing: responseString!)
            self.errorMessage.text! = responseMessage
            print(self.errorMessage.text!)
        }
        task.resume()
    }
    
    
}
