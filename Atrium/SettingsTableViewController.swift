import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var switchNews: UISwitch!
    @IBOutlet weak var switchEvents: UISwitch!
    @IBOutlet weak var switchPromo: UISwitch!
    
    var switchMemory = UserDefaults.standard
    var backTo = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if switchMemory.value(forKey: "news") != nil {
            let checkNews = switchMemory.value(forKey: "news") as! Bool
            if checkNews { switchNews.isOn = true }
            else { switchNews.isOn = false }
        }
        if switchMemory.value(forKey: "events") != nil {
            let checkEvents = switchMemory.value(forKey: "events") as! Bool
            if checkEvents { switchEvents.isOn = true }
            else { switchEvents.isOn = false }
        }
        if switchMemory.value(forKey: "promo") != nil {
            let checkPromo = switchMemory.value(forKey: "promo") as! Bool
            if checkPromo { switchPromo.isOn = true }
            else { switchPromo.isOn = false }
        }
    }
    
    func unwind() {
        if backTo == "news" {
            self.performSegue(withIdentifier: "unwindToNews", sender: self)
        }
        else if backTo == "events" {
            self.performSegue(withIdentifier: "unwindToEvents", sender: self)
        }
        else if backTo == "brands" {
            self.performSegue(withIdentifier: "unwindToBrands", sender: self)
        }
        else if backTo == "info" {
            self.performSegue(withIdentifier: "unwindToInfo", sender: self)
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        unwind()
    }
    
    @IBAction func save(_ sender: AnyObject) {
        if switchNews.isOn { switchMemory.setValue(true, forKey: "news") }
        if !switchNews.isOn { switchMemory.setValue(false, forKey: "news") }
        if switchEvents.isOn { switchMemory.setValue(true, forKey: "events") }
        if !switchEvents.isOn { switchMemory.setValue(false, forKey: "events") }
        if switchPromo.isOn { switchMemory.setValue(true, forKey: "promo") }
        if !switchPromo.isOn { switchMemory.setValue(false, forKey: "promo") }
        unwind()
    }

}
