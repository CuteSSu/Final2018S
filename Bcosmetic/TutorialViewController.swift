import UIKit
import CoreData

class TutorialViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var textName: UITextField!
    @IBOutlet var textTools: UITextView!
    @IBOutlet var textHowto: UITextView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textTools{
            textField.resignFirstResponder()
            self.textHowto.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    @IBAction func saveTutorial(_ sender: UIBarButtonItem) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Tutorial", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        object.setValue(textName.text, forKey: "name")
        object.setValue(textTools.text, forKey: "tools")
        object.setValue(textHowto.text, forKey: "howto")
        object.setValue(Date(), forKey: "saveDate")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        self.navigationController?.popViewController(animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
