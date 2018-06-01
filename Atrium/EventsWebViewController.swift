import UIKit

class EventsWebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var urlToGo = String()
    var titleToGo = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "http://www.atriumcenter.com.ua/events/\(urlToGo)")
        let requestObj = NSURLRequest(url: url! as URL)
        webView.loadRequest(requestObj as URLRequest);
    }
    
    @IBAction func share(_ sender: Any) {
        let textToShare = titleToGo
        if let myWebsite = NSURL(string: "http://www.atriumcenter.com.ua/events/\(urlToGo)") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems:objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
}
