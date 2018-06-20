
import Foundation
import UIKit

class forgetPassword: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var formStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.formStatus.text = ""
    }
    
    
    @IBAction func emailResponse(_ sender: UIButton) {
        let postString = "email=\(emailText.text!)&token_signup=06232017Job$"
        let urlString = "http://www.lovegreenguide.com/getp_app.php"
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
            print("responseString = \(String(describing: responseString!))")
            self.formStatus.text = String(describing: responseString!)
        }
        task.resume()
    }
}
