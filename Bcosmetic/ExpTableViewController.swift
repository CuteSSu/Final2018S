import UIKit
import CoreData

class ExpTableViewController: UITableViewController {

    var cosmetics2: [NSManagedObject] = []

    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Exp Cell", for: indexPath)
        
        // Configure the cell...
        let cosmetic = cosmetics2[indexPath.row]
        var display: String = ""
        if let nameLabel = cosmetic.value(forKey: "name") as? String {
            display = nameLabel
        }
        cell.textLabel?.text = display
    
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let dbDate: Date? = cosmetic.value(forKey: "expdate") as? Date
        if let unwrapDate = dbDate {
            let displayDate = formatter.string(from: unwrapDate as Date)
            cell.detailTextLabel?.text = displayDate
            
            let now = Date()
            let date = DateFormatter()
            date.dateFormat = "MM-dd-yyyy"
            let today = date.string(from: now)
            if displayDate < today{
                cell.textLabel?.text = display + "            !! 유통기한이 지났습니다. !!"
            }
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cosmetics")
        
        let sortDescriptor = NSSortDescriptor (key: "expdate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            cosmetics2 = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)") }
        
       self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cosmetics2.count
    }
   
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
        let context = getContext()
        context.delete(cosmetics2[indexPath.row])
        do {
            try context.save()
            print("deleted!")
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)")
            
        }
        // 배열에서 해당 자료 삭제
        cosmetics2.remove(at: indexPath.row)
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     }
     }
}
