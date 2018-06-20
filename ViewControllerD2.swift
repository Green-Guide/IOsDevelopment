import UIKit
import Foundation
import CoreLocation

class ViewControllerD2: UIViewController {
    
    
    @IBOutlet weak var averageValue: UILabel!
    @IBOutlet var barWidths: [UIImageView]!
    
    override func viewDidLoad() {
        var barWidthValues = [0,0,0,0,0,0,0]
        var average = Double()
        super.viewDidLoad()
        for index in 0...(reviewRatings.count - 1) {
            var reviewNumberRaw = reviewRatings[index]
            switch reviewNumberRaw {
            case "-3.0000":
                barWidthValues[0] += 1
            case "-2.0000":
                barWidthValues[1] += 1
            case "-1.0000":
                barWidthValues[2] += 1
            case "0.0000":
                barWidthValues[3] += 1
            case "1.0000":
                barWidthValues[4] += 1
            case "2.0000":
                barWidthValues[5] += 1
            case "3.0000":
                barWidthValues[6] += 1
            default: break
            }
        }
        var total = 0.0
        for barIndex in 0...(barWidthValues.count - 1) {
            var width = 20 * barWidthValues[barIndex]
            if (width == 0) {
                width = 1
            }
            barWidths[barIndex].frame.size.width = CGFloat(width)
            if(barWidthValues[barIndex] != 0) {
                var adder = Double(barWidths[barIndex].tag * barWidthValues[barIndex])
                total = total + adder
            }
        }
        average = (total)/(Double(reviewRatings.count))
        averageValue.text! = "Average: \(average)"
        //reviewRatings.removeAll()
        specificDataDetails(lng: longitude, lat: latitude)
        //print(longitude)
        //print(latitude)
    }
    
    public func specificDataDetails(lng: String, lat: String) {
        let parameters = ["address": "address", "average":"average", "city":"city", "company": "company", "lat":"lat", "lng":"lng"]
        guard let url = URL(string: specificData + "lng=\(lng)&lat=\(lat)")else { return }
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
                    var jsonArray = (json as? [[String:Any]])!
                    var airDetails = jsonArray[0]["air"] as! [String:Any]
                    var reviewDetails = jsonArray[0]["review"] as! [String:Any]
                    var solidDetails = jsonArray[0]["solid"] as! [String:Any]
                    var waterDetails = jsonArray[0]["water"] as! [String:Any]
                    print(airDetails)
                    print(reviewDetails)
                    print(solidDetails)
                    print(waterDetails)
                }catch {
                    print(error)
                }
            }
            }.resume()
    }
    
}
