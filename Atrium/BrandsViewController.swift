import UIKit

class BrandsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBAction func unwindToBrands(segue: UIStoryboardSegue) {
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var shopsItems = [Brands]()
    var restaurantsItems = [Brands]()
    var entertainmentItems = [Brands]()
    var servicesItems = [Brands]()
    var brands = [Brands]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.isEnabled = false
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "detailView" {
            let destination = segue.destination as! BrandsDetailViewController
            let indexPathItem = collectionView.indexPathsForSelectedItems?.first
            let item = brands[(indexPathItem?.item)!]
            destination.id = item.id
        }
        if segue.identifier ==  "settings" {
            let nav = segue.destination as! UINavigationController
            let destination = nav.topViewController as! SettingsTableViewController
            destination.backTo = "brands"
        }
    }
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            brands = shopsItems
            self.collectionView?.reloadData()
        case 1:
            brands = restaurantsItems
            self.collectionView?.reloadData()
        case 2:
            brands = entertainmentItems
            self.collectionView?.reloadData()
        case 3:
            brands = servicesItems
            self.collectionView?.reloadData()
        default:
            break
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brands.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandsCollectionViewCell", for: indexPath) as! BrandsCollectionViewCell
        let items = brands[indexPath.row]
        cell.photoImageView.image = items.image
        cell.titleLabel.text = items.title
        cell.typeLabel.text = items.type
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func getData() {
        guard let url = URL(string: "\(apiFolder)get_data.php?rubric=brands") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let json: Any?
            do {
                json = try JSONSerialization.jsonObject(with: data, options: [])
            }
            catch { return }
            guard let dataList = json as? NSArray else { return }
            if let brandsList = json as? NSArray {
                for i in 0 ..< dataList.count {
                    let items = brandsList[i] as! NSDictionary
                    let imageUrl = items["image"] as! String
                    let title = items["title"] as! String
                    let type = items["type"] as! String
                    let itemUrl = items["url"] as! String
                    let catId = items["cat_id"] as! String
                    let id = items["id"] as! String
                    let url = NSURL(string: imgFolder + imageUrl)!
                    let data = NSData(contentsOf : url as URL)
                    let image = UIImage(data : data! as Data)
                    let array = Brands(title: title, type: type, image: image, url: itemUrl, catId: catId, id: id)!
                    if catId == "11" {
                        self.shopsItems += [array]
                    }
                    else if catId == "12" {
                        self.restaurantsItems += [array]
                    }
                    else if catId == "13" {
                        self.entertainmentItems += [array]
                    }
                    else if catId == "14" {
                        self.servicesItems += [array]
                    }
                }
            }
            self.brands = self.shopsItems
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
                self.activityIndicator.stopAnimating()
                self.segmentedControl.isEnabled = true
            })
        }.resume()
    }
    
}
