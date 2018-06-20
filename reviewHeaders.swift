//
//  reviewHeaders.swift
//  interface
//
//  Created by Ankita Vaid on 2/13/18.
//  Copyright © 2018 Ankita Vaid. All rights reserved.
//

import Foundation


class reviewHeaders: UIViewController {
    
    let components = (address : "address",average : "avg_r", city : "city",
                      company : "company", lat : "lat", lng : "lng", numberOfReviews : "num_r")
    var numberOfReviews = 8
    var reviews = [[""],[""],[""],[""],[""],[""],[""],[""]]
    
    let reviewData = "http://www.lovegreenguide.com/map_point_app.php?lng=116.492394&lat=39.884462"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getData() {
        if let url = URL(string : self.reviewData) {
            let session = URLSession.shared.dataTask(with : url, completionHandler : { (data, response,error) in
                if let data = data {
                    do {
                        var json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                        for i in 0...(json.count - 1) {
                            self.reviews[i] = [(json[i][self.components.address] as? String)!,
                                               (json[i][self.components.average] as? String)!,
                                               (json[i][self.components.city] as? String)!,
                                               (json[i][self.components.company] as? String)!,
                                               (json[i][self.components.lat] as? String)!,
                                               (json[i][self.components.lng] as? String)!]
                            print(self.reviews[i])
                        }
                    }catch {
                        print(error)
                    }
                }
            })
            session.resume()
        }
        //            let parameters = ["address": "address", "average":"average", "city":"city", "company": "company", "lat":"lat", "lng":"lng"]
        //            var lng = 0
        //            var lat = 0
        //            guard let url = URL(string: "http://www.lovegreenguide.com/map_point_app.php?lng=116.492394&lat=39.884462")else { return }
        //            var request = URLRequest(url: url)
        //            request.httpMethod = "POST"
        //            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])else { return }
        //            request.httpBody = httpBody
        //
        //            let session = URLSession.shared
        //            session.dataTask(with: request) { (data, response, error) in
        //                if let response = response {
        //                    print(response)
        //                }
        //
        //                if let data = data {
        //                    do {
        //                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        //                        print(json)
        //                    }catch {
        //                        print(error)
        //                    }
        //                }
        //
        //            }.resume()
    }
}

