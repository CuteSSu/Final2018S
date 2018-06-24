
import UIKit
import CoreData

class DetailViewController: UIViewController {
    @IBOutlet var textName: UILabel!
    @IBOutlet var textNickname: UILabel!
    @IBOutlet var textFirst: UILabel!
    @IBOutlet var textSecond: UILabel!
    @IBOutlet var textBrand: UILabel!
    @IBOutlet var textOpen: UILabel!
    @IBOutlet var textBb: UILabel!
    
    
    var detailCosmetic: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let cosmetic = detailCosmetic {
            textName.text = cosmetic.value(forKey: "name") as? String
            textNickname.text = cosmetic.value(forKey: "nickname") as? String
            textFirst.text = cosmetic.value(forKey: "firstCategory") as? String
            textSecond.text = cosmetic.value(forKey: "secondCategory") as? String
            textBrand.text = cosmetic.value(forKey: "brand") as? String
            textOpen.text = cosmetic.value(forKey: "opendate") as? String
            //textBb.text = cosmetic.value(forKey: "expdate") as? String
            
            let dbDate: Date? = cosmetic.value(forKey: "expdate") as? Date
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            if let unwrapDate = dbDate {
                let displayDate = formatter.string(from: unwrapDate as Date)
                 textBb.text = displayDate
            }
            
        }
    }
}
