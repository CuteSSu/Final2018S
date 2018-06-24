import UIKit
import CoreData

class AddCosmeticViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UINavigationControllerDelegate {

    @IBOutlet var textName: UITextField!
    @IBOutlet var textNickname: UITextField!
    @IBOutlet var textBrand: UITextField!
    @IBOutlet var textFirstCategory: UITextField!
    @IBOutlet var textSecondCategory: UITextField!
    @IBOutlet var textOpendate: UITextField!
    @IBOutlet var pickerDateTime: UIDatePicker!
    @IBOutlet var doneButton: UIButton!
    
    
    var firstCategory = ["스킨케어","메이크업","바디&헤어","기타"]
    let categoryPicker = UIPickerView()
    let openDatePicker = UIDatePicker()
   
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func getDateTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Cosmetics", in: context)
        
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textName.text, forKey: "name")
        object.setValue(textNickname.text, forKey: "nickname")
        object.setValue(textBrand.text, forKey: "brand")
        object.setValue(textFirstCategory.text, forKey: "firstCategory")
        object.setValue(textSecondCategory.text, forKey: "secondCategory")
        object.setValue(textOpendate.text, forKey: "opendate")
        object.setValue(Date(), forKey: "saveDate")
        object.setValue(pickerDateTime.date, forKey: "expdate")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)") }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.plain, target: self, action: #selector(categoryDonePressed))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textFirstCategory.inputView = categoryPicker
        textFirstCategory.inputAccessoryView = toolBar
        createOpenDatePicker()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return firstCategory.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return firstCategory[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFirstCategory.text = firstCategory[row]
    }
    
    @objc func categoryDonePressed(){
        let indexPath = categoryPicker.selectedRow(inComponent: 0)
        textFirstCategory.text = firstCategory[indexPath]
        self.view.endEditing(true)
    }
    
    func createOpenDatePicker(){
        
        // format for picker
        openDatePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(opendateDonePressed))
        toolbar.setItems([doneButton], animated: false)
        
        textOpendate.inputAccessoryView = toolbar
        
        // assinging date picker to text field
        textOpendate.inputView = openDatePicker
    }

    @objc func opendateDonePressed(){
        
        // format date
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .none
        
        textOpendate.text = dateformatter.string(from: openDatePicker.date)
        self.view.endEditing(true)
    }
}
