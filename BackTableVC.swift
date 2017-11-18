//
//  BackTableVC.swift
//  interface
//


import Foundation

class BackTableVC : UITableViewController {
    
    var TableArray = [String]()
    var aboutSub = ["About Us", "Join Us", "Contact Us"]
    var userSub = ["User Measurement Guide", "Pollution Impact", "Successful Environmental Restore Cases"]
    
    override func viewDidLoad() {
        TableArray = ["My Reviews", "Guidelines", "About Us", "User Guide", "Sign Up", "Log In/Out", "中文"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        cell.textLabel?.text = TableArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(TableArray[indexPath.row])
    }
    
    
}
