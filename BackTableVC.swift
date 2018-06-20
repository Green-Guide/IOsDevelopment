
import Foundation

class BackTableVC : UITableViewController {
    
    var TableArray = [String]()
    var enable = login.userDetails.isSuccess
    var emailAddress = login.userDetails.emailAddress
    var aboutSub = ["About Us", "Join Us", "Contact Us"]
    var userSub = ["User Measurement Guide", "Pollution Impact", "Successful Environmental Restore Cases"]
    override func viewDidLoad() {
        TableArray = ["User Email Address", "My Reviews", "Guidelines", "About Us", "User Guide", "Sign Up", "Log In", "Log Out", "中文"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        cell.textLabel?.text = TableArray[indexPath.row]
        if(cell.textLabel?.text == "User Email Address") {
            cell.textLabel?.text = emailAddress
        }
        if(!enable) {
            if(cell.textLabel?.text == "Log Out") {
                cell.isHidden = true
            }else if(cell.textLabel?.text == "Log In") {
                cell.isHidden = false
            }
        }else {
            if(cell.textLabel?.text == "Log Out") {
                cell.isHidden = false
            }else if(cell.textLabel?.text == "Log In") {
                cell.isHidden = true
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(TableArray[indexPath.row])
    }
    
    
}
