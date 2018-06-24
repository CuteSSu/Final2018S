import UIKit
import MapKit
class StoreViewController: UIViewController {
    @IBOutlet var map: MKMapView!
    
    var selectedIndex: Int? = nil
    
    var store: Store? = nil
    
    var storeAnnotation: Store? = nil
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 가장 최근의 위치 값
        let location: CLLocation = locations[locations.count-1]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _ = selectedIndex {
            map.setRegion(MKCoordinateRegionMake((self.store?.coordinate)!, MKCoordinateSpanMake(0.007, 0.007)), animated: true)
        }
        
        // 기존의 맵에 annotation이 있었다면 삭제
        if let annotation = storeAnnotation {
            self.map.removeAnnotation(annotation)
        }
        // 새로운 annotation 위치가 있다면 추가
        if let annotation = store {
            self.storeAnnotation = annotation
            self.map.addAnnotation(self.storeAnnotation!)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStoreView" {
            if let destVC = segue.destination as? StoreTableViewController {
                destVC.mainVC = self
            } }
    }

    
}
