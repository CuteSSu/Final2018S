import UIKit

class StoreTableViewController: UITableViewController {

   
    var stores:[Store] = []
    
    var mainVC: StoreViewController? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var store: Store
        store = Store(title: "올리브영", latitude:37.6155230 , longtitude: 127.0638980)
        self.stores.append(store)
        store = Store(title: "아리따움", latitude:37.6207820 , longtitude: 127.0836070)
        self.stores.append(store)
        store = Store(title: "이니스프리", latitude:37.6266280 , longtitude: 127.0794110)
        self.stores.append(store)
        store = Store(title: "더페이스샵", latitude:37.6272410 , longtitude: 127.0787680)
        self.stores.append(store)
        store = Store(title: "스킨푸드", latitude:37.6137970 , longtitude: 127.0775030)
        self.stores.append(store)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "화장품 가게를 선택하세요"
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stores.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.mainVC?.selectedIndex = indexPath.row
        self.mainVC?.store = self.stores[indexPath.row]
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Store Cell", for: indexPath)
        cell.textLabel?.text = self.stores[indexPath.row].title
        if let view = self.mainVC {
            if let index = view.selectedIndex {
                if index == indexPath.row {
                    cell.accessoryType = .checkmark }
                else {
                    cell.accessoryType = .none }
            } }
        
        
        return cell
}


/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
}
