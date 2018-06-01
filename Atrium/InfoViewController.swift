import UIKit

class InfoViewController: UIViewController {
    
    @IBAction func unwindToInfo(segue: UIStoryboardSegue) {
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contactsView: UIView!
    @IBOutlet weak var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsView.isHidden = false
        mapView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "settings" {
            let nav = segue.destination as! UINavigationController
            let destination = nav.topViewController as! SettingsTableViewController
            destination.backTo = "info"
        }
    }
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            contactsView.isHidden = false
            mapView.isHidden = true
        case 1:
            contactsView.isHidden = true
            mapView.isHidden = false
        default:
            break
        }
    }
    
}
