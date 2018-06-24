import UIKit
import CoreData

class TutorialDetialViewController: UIViewController {

    @IBOutlet var textName: UILabel!
    @IBOutlet var textTools: UITextView!
    @IBOutlet var textHowto: UITextView!
    
    var detailTutorial: NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tutorial = detailTutorial {
            textName.text = tutorial.value(forKey: "name") as? String
            textTools.text = tutorial.value(forKey: "tools") as? String
            textHowto.text = tutorial.value(forKey: "howto") as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
