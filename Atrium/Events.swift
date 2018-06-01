import UIKit

class Events {

    var image: UIImage?
    var title: String
    var date: String
    var url: String
    
    init?(image: UIImage?, title: String, date: String, url: String) {
        self.image = image
        self.title = title
        self.date = date
        self.url = url
        if title.isEmpty {
            return nil
        }
    }
    
}
