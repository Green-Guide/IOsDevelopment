import UIKit
import Foundation
import CoreLocation

//Global Variable for basic review data
struct reviewInfo {
    static var reviewDetails = [[String:Any]]()
}
var reviewNumber = 0
//-3 to 3 Rating, grab "rating" value from each review and place into an array
var reviewRatings = [String]()
let reviewData = "http://www.lovegreenguide.com/search-all_one_app.php?s_company="
let specificData = "http://www.lovegreenguide.com/map_point_co_app.php?"
var latitude = String()
var longitude = String()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var specificReview: UILabel!
    @IBOutlet weak var companySearch: UITextField!
    
    let components = (address : "address",average : "avg_r", city : "city",
                      company : "company", lat : "lat", lng : "lng", numberOfReviews : "num_r")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func getData() {
            let parameters = ["address": "address", "average":"average", "city":"city", "company": "company", "lat":"lat", "lng":"lng"]
            var lng = 0
            var lat = 0
            guard let url = URL(string: reviewData + self.companySearch.text!)else { return }
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
                        reviewInfo.reviewDetails = [[:]]
                        reviewInfo.reviewDetails = (json as? [[String:Any]])!
                        for index in 0...(reviewInfo.reviewDetails.count - 1) {
                            if(reviewInfo.reviewDetails[index]["avg_r"] != nil) {
                                reviewRatings.append(reviewInfo.reviewDetails[index]["avg_r"] as! String)
                            }
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }catch {
                        print(error)
                    }
                }
            }.resume()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        return reviewInfo.reviewDetails.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        var address = " "
        var average = " "
        var city = " "
        var company = " "
        var lat = " "
        var lng = " "
        if(reviewInfo.reviewDetails[indexPath.row]["address"] != nil) {
            address = reviewInfo.reviewDetails[indexPath.row]["address"] as! String
        }
        if(reviewInfo.reviewDetails[indexPath.row]["average"] != nil) {
            average = reviewInfo.reviewDetails[indexPath.row]["average"] as! String
        }
        if(reviewInfo.reviewDetails[indexPath.row]["city"] != nil) {
            city = reviewInfo.reviewDetails[indexPath.row]["city"] as! String
        }
        if(reviewInfo.reviewDetails[indexPath.row]["company"] != nil) {
            company = reviewInfo.reviewDetails[indexPath.row]["company"] as! String
        }
        if(reviewInfo.reviewDetails[indexPath.row]["lat"] != nil) {
            lat = reviewInfo.reviewDetails[indexPath.row]["lat"] as! String
        }
        if(reviewInfo.reviewDetails[indexPath.row]["lng"] != nil) {
            lng = reviewInfo.reviewDetails[indexPath.row]["lng"] as! String
        }
        cell.textLabel?.text = "Review \(indexPath.row + 1) " + "\n" + address + "\n" + average + "\n" + city + "\n" + company + "\n" + lat + "\n" + lng
        cell.textLabel?.numberOfLines = 0
        return(cell)
    }
    
    @IBAction func searchForCompany(_ sender: UIButton) {
        self.specificReview.text = "Showing \(self.companySearch.text!) Reviews"
        getData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reviewNumber = indexPath.row
        latitude = reviewInfo.reviewDetails[indexPath.row]["lat"] as! String
        longitude = reviewInfo.reviewDetails[indexPath.row]["lng"] as! String
        performSegue(withIdentifier: "showReviewDetails", sender: self)
    }
}

