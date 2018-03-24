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

//Load review information details into one tableviewcell

//Baidu Maps Key: jGZyhLYClQ5VasDSrAtcGEvh4nUcIiAz

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var specificReview: UILabel!
    @IBOutlet weak var companySearch: UITextField!
    
    struct reviewInfo {
        static var reviewDetails = [[String:Any]]()
    }
    
    let components = (address : "address",average : "avg_r", city : "city",
                      company : "company", lat : "lat", lng : "lng", numberOfReviews : "num_r")
    var numberOfReviews = Int()
    var reviews = [[""],[""],[""],[""],[""],[""],[""],[""]]
    var reviewIndex = [Int]()
    
    let reviewData = "http://www.lovegreenguide.com/map_point_app.php?lng=116.492394&lat=39.884462"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func getData() {
            let parameters = ["address": "address", "average":"average", "city":"city", "company": "company", "lat":"lat", "lng":"lng"]
            var lng = 0
            var lat = 0
            guard let url = URL(string: reviewData)else { return }
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
                        var reviewAux = [[String:Any]]()
                        for i in 0...reviewInfo.reviewDetails.count-1 {
                            if(self.companySearch.text! != "") {
                                if(reviewInfo.reviewDetails[i]["company"] as? String == self.companySearch.text) {
                                    reviewAux.append(reviewInfo.reviewDetails[i])
                                }
                            }
                        }
                        if(reviewAux.count != 0) {
                            reviewInfo.reviewDetails = reviewAux
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
}

