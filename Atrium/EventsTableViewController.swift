import UIKit
import CoreData

class EventsTableViewController: UITableViewController {
    
    @IBAction func unwindToEvents(segue: UIStoryboardSegue) {
    }
    var allItems = [Events]()
    var coreData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        extractCoreData()
        tableView.estimatedRowHeight = 305.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "webView" {
            let destination = segue.destination as! EventsWebViewController
            let indexPathRow = tableView.indexPathForSelectedRow?.row
            let item = allItems[indexPathRow!]
            destination.urlToGo = item.url
            destination.titleToGo = item.title
        }
        if segue.identifier ==  "settings" {
            let nav = segue.destination as! UINavigationController
            let destination = nav.topViewController as! SettingsTableViewController
            destination.backTo = "events"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell", for: indexPath) as! EventsTableViewCell
        let items = allItems[indexPath.row]
        cell.titleLabel.text = items.title
        cell.dateLabel.text = items.date
        cell.photoImageView.image = items.image
        let imageHeight = cell.photoImageView.image!.size.height
        let imageWidth = cell.photoImageView.image!.size.width
        let finalHeightOfImageView = (imageHeight / imageWidth) * 359
        cell.imageHeightConstraint.constant = finalHeightOfImageView
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func extractCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            coreData = results as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
        for i in 0 ..< coreData.count {
            let items = coreData[i]
            let title = items.value(forKey: "title") as! String
            let date = items.value(forKey: "date") as! String
            let url = items.value(forKey: "url") as! String
            let imageFromData = items.value(forKey: "image")
            let image = UIImage(data : imageFromData as! Data)
            let array = Events(image: image, title: title, date: date, url: url)!
            allItems += [array]
        }
        DispatchQueue.main.async(execute: {self.tableView.reloadData()})
    }
    
}
