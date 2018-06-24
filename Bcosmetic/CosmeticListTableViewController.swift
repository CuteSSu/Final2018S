import UIKit
import CoreData

class CosmeticTableViewCell: UITableViewCell{
    @IBOutlet var cellName: UILabel!
    @IBOutlet var cellNickname: UILabel!
    @IBOutlet var cellFirstCategory: UILabel!
    @IBOutlet var cellSecondCategory: UILabel!
    @IBOutlet var cellOpendate: UILabel!
    @IBOutlet var cellBbdate: UILabel!
    
}

class CosmeticListTableViewController: UITableViewController {
    
    var cosmetics: [NSManagedObject] = []

    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
        self.present(loginView, animated: true, completion: nil)
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cosmetics")
      
        let sortDescriptor = NSSortDescriptor (key: "saveDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            cosmetics = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cosmetics.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cosmetics Cell", for: indexPath) as! CosmeticTableViewCell
        // Configure the cell...
        let cosmetic = cosmetics[indexPath.row]
        cell.cellName?.text = cosmetic.value(forKey: "name") as? String
        cell.cellNickname?.text = cosmetic.value(forKey: "nickname") as? String
        cell.cellFirstCategory?.text = cosmetic.value(forKey: "firstCategory") as? String
        cell.cellSecondCategory?.text = cosmetic.value(forKey: "secondCategory") as? String
        cell.cellOpendate?.text = cosmetic.value(forKey: "opendate") as? String
        let dbDate: Date? = cosmetic.value(forKey: "expdate") as? Date
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        if let unwrapDate = dbDate {
            let displayDate = formatter.string(from: unwrapDate as Date)
             cell.cellBbdate?.text = displayDate
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let context = getContext()
            context.delete(cosmetics[indexPath.row])
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)")
            }
            cosmetics.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.detailCosmetic = cosmetics[selectedIndex]
                }
            }
        }
    }
}
