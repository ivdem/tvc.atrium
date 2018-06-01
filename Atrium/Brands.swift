import UIKit

class Brands {
    
    var title: String
    var type: String
    var image: UIImage?
    var url: String
    var catId: String
    var id: String
    
    init?(title: String, type: String, image: UIImage?, url: String, catId: String, id: String) {
        self.title = title
        self.type = type
        self.image = image
        self.url = url
        self.catId = catId
        self.id = id
        if title.isEmpty {
            return nil
        }
    }
}
