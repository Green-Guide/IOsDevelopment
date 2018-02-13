import UIKit
import Foundation
import CoreLocation

//Need to start session to get each single review, ineffecient.
//But on other hand user can tap to advance and go back to 
//view each review
//Takes time on XCode Simulator to display review
//JSON Data only exists within scope then goes back to default
//Test with actual device versus simulator to check on any 
//performance changes

//Baidu Maps Key: jGZyhLYClQ5VasDSrAtcGEvh4nUcIiAz

class ViewController: UIViewController {

    @IBOutlet weak var reviewNumber: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    let components = (address : "address",average : "avg_r", city : "city",
                      company : "company", lat : "lat", lng : "lng", numberOfReviews : "num_r")
    var numberOfReviews = 8
    var reviews = [[""],[""],[""],[""],[""],[""],[""],[""]]
    
    var currentReview = 1
    
    let reviewData = "http://www.lovegreenguide.com/map_point_app.php?lng=116.492394&lat=39.884462"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.isEnabled = false
        getData(index:currentReview - 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        currentReview-=1
        getData(index: currentReview - 1)
        if(self.currentReview == self.numberOfReviews - 1) {
            forwardButton.isEnabled = true
        }
        if(self.currentReview == 1) {
            backButton.isEnabled = false
        }
    }
    
    @IBAction func goForward(_ sender: UIButton) {
        currentReview+=1
        getData(index: currentReview - 1)
        if(self.currentReview > 1) {
            backButton.isEnabled = true
        }
        if(self.currentReview == self.numberOfReviews) {
            forwardButton.isEnabled = false
        }
    }
    
    func getData(index : Int) {
//        if let url = URL(string : self.reviewData) {
//            let session = URLSession.shared.dataTask(with : url, completionHandler : { (data, response,error) in
//                if let data = data {
//                    do {
//                        var json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
//                        for i in 0...(json.count - 1) {
//                            self.reviews[i] = [(json[i][self.components.address] as? String)!,
//                                             (json[i][self.components.average] as? String)!,
//                                             (json[i][self.components.city] as? String)!,
//                                             (json[i][self.components.company] as? String)!,
//                                             (json[i][self.components.lat] as? String)!,
//                                             (json[i][self.components.lng] as? String)!]
//                        }
//                    }catch {
//                        print(error)
//                    }
//                }
//            })
//            session.resume()
//        }
            let parameters = ["address": "address", "average":"average", "city":"city", "company": "company", "lat":"lat", "lng":"lng"]
            var lng = 0
            var lat = 0
            guard let url = URL(string: "http://www.lovegreenguide.com/map_point_app.php?lng=116.492394&lat=39.884462")else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])else { return }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    }catch {
                        print(error)
                    }
                }
            }.resume()
        }
}

