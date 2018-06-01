


/*
func uploadNews() {
    guard let url = URL(string: "\(apiFolder)get_data.php?rubric=news") else { return }
    let session = URLSession.shared
    
    session.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        //            let json: Any?
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data, options: [])
        //            } catch {
        //                return
        //            }
        
        let json = JSONSerialization.jsonObject(with: data, options: [])
        //////
        
        guard let dataList = json as? NSArray else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
        fetchRequest.returnsObjectsAsFaults = false
        if let itemsList = json as? NSArray {
            for i in 0 ..< dataList.count {
                let items = itemsList[i] as! NSDictionary
                let id = items["id"] as! String
                let imageFromJson = items["image"] as! String
                let title = items["title"] as! String
                let date = items["date"] as! String
                let urlFromJson = items["url"] as! String
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                do {
                    let results = try managedContext.fetch(fetchRequest)
                    self.coreData = results as! [NSManagedObject]
                }
                catch let error as NSError {
                    print("Error: \(error)")
                }
                if self.coreData.count == 0 {
                    let url = NSURL(string: "\(imgFolder)\(imageFromJson)")!
                    let data = NSData(contentsOf : url as URL)
                    let entity =  NSEntityDescription.entity(forEntityName: "News", in: managedContext)
                    let saveData = NSManagedObject(entity: entity!, insertInto: managedContext)
                    saveData.setValue(id, forKey: "id")
                    saveData.setValue(data, forKey: "image")
                    saveData.setValue(title, forKey: "title")
                    saveData.setValue(date, forKey: "date")
                    saveData.setValue(urlFromJson, forKey: "url")
                    do {
                        try managedContext.save()
                    }
                    catch let error as NSError {
                        print("Error: \(error)")
                    }
                }
            }
        }
        self.uploadEvents()
        }.resume()
}

*/


import UIKit
import CoreData

class LaunchViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var coreData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadNews()
    }
    
    func uploadNews() {
        let getDataUrl = URL(string: "\(apiFolder)get_data.php?rubric=news")
        let session = URLSession.shared
        
        session.dataTask(with: getDataUrl!) { (data, response, error) in
            
            let jsonData: Any?
            do {
                jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
            } catch {
                return
            }
            
            guard let dataList = jsonData as? NSArray else {
                return
            }
            
            let managedContext = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
            fetchRequest.returnsObjectsAsFaults = false
            
            if let itemsList = jsonData as? NSArray {
                for i in 0 ..< dataList.count {
                    let items = itemsList[i] as! NSDictionary
                    let id = items["id"] as! String
                    let imageFromJson = items["image"] as! String
                    let title = items["title"] as! String
                    let date = items["date"] as! String
                    let url = items["url"] as! String
                    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                    
                    do {
                        let result = try managedContext.fetch(fetchRequest)
                        self.coreData = result as! [NSManagedObject]
                    } catch {
                        return
                    }
                    
                    if self.coreData.count == 0 {
                        let imageUrl = NSURL(string: "\(imgFolder)\(imageFromJson)")!
                        let data = NSData(contentsOf : imageUrl as URL)
                        let entity =  NSEntityDescription.entity(forEntityName: "News", in: managedContext)
                        let saveData = NSManagedObject(entity: entity!, insertInto: managedContext)
                        
                        saveData.setValue(id, forKey: "id")
                        saveData.setValue(data, forKey: "image")
                        saveData.setValue(title, forKey: "title")
                        saveData.setValue(date, forKey: "date")
                        saveData.setValue(url, forKey: "url")
                        
                        do {
                            try managedContext.save()
                        } catch {
                            return
                        }
                    }
                }
            }
            self.uploadEvents()
            
        }.resume()
        
    }
    
    
    
    
    func uploadEvents() {
        guard let url = URL(string: "\(apiFolder)get_data.php?rubric=events") else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let json: Any?
            do {
                json = try JSONSerialization.jsonObject(with: data, options: [])
            }
            catch {
                return
            }
            
            guard let dataList = json as? NSArray else {
                return
            }
            
            let managedContext = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Events")
            fetchRequest.returnsObjectsAsFaults = false
            if let itemsList = json as? NSArray {
                for i in 0 ..< dataList.count {
                    let items = itemsList[i] as! NSDictionary
                    let id = items["id"] as! String
                    let imageFromJson = items["image"] as! String
                    let title = items["title"] as! String
                    let date = items["date"] as! String
                    let urlFromJson = items["url"] as! String
                    fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                    do {
                        let results = try managedContext.fetch(fetchRequest)
                        self.coreData = results as! [NSManagedObject]
                    }
                    catch let error as NSError {
                        print("Error: \(error)")
                    }
                    if self.coreData.count == 0 {
                        let url = NSURL(string: imgFolder + imageFromJson)!
                        let data = NSData(contentsOf : url as URL)
                        let entity =  NSEntityDescription.entity(forEntityName: "Events", in: managedContext)
                        let saveData = NSManagedObject(entity: entity!, insertInto: managedContext)
                        saveData.setValue(id, forKey: "id")
                        saveData.setValue(data, forKey: "image")
                        saveData.setValue(title, forKey: "title")
                        saveData.setValue(date, forKey: "date")
                        saveData.setValue(urlFromJson, forKey: "url")
                        do {
                            try managedContext.save()
                        }
                        catch let error as NSError {
                            print("Error: \(error)")
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "showApp", sender: self)
            }
        }.resume()
    }
    
}
