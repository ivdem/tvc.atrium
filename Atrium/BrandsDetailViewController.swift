import UIKit

class BrandsDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var id = String()
    var text = NSAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.isHidden = true
        getDataFromUrl("\(apiFolder)get_data.php?brand_id=\(id)")
    }

    func getDataFromUrl(_ link:String) {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                return
            }
            self.extractJson(data!)
        })
        task.resume()
    }
    
    func extractJson(_ data: Data) {
        let json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch {
            return
        }
        if let itemsList = json as? NSArray {
            let items = itemsList[0] as! NSDictionary
            let name = items["name"] as! String
            let type = items["type"] as! String
            let imageFromJson = items["image"] as! String
            let backgroundFromJson = items["bg"] as! String
            let textFromUrl = items["text"] as! String
            let imageUrl = NSURL(string: imgFolder + imageFromJson)!
            let imageData = NSData(contentsOf : imageUrl as URL)
            let image = UIImage(data : imageData! as Data)
            let backgroundUrl = NSURL(string: imgFolder + backgroundFromJson)!
            let backgroundData = NSData(contentsOf : backgroundUrl as URL)
            let background = UIImage(data : backgroundData! as Data)
            do {
                text = try NSAttributedString(data: textFromUrl.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            } catch let error as NSError {
                print("Error: \(error)")
            }
            DispatchQueue.main.async() {
                self.backgroundImage.image = background
                self.logoImage.image = image
                self.titleLabel.text = name
                self.typeLabel.text = type
                self.textView.attributedText = self.text
                self.activityIndicator.stopAnimating()
                self.logoImage.isHidden = false
            }
        }
    }
    
}
