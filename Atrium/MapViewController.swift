import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 49.551461, longitude: 25.591316)
        let regionRadius: CLLocationDistance = 400
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: 49.551461, longitude: 25.591316)
            annotation.title = mapTitle
            annotation.subtitle = mapSubtitle
            mapView.addAnnotation(annotation)
        }
        centerMapOnLocation(location: initialLocation)
    }
    
}
