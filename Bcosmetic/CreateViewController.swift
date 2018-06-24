import UIKit
import CoreData

class CreateViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textName: UITextField!
    @IBOutlet var textID: UITextField!
    @IBOutlet var textPassword: UITextField!
    @IBOutlet var textNickname: UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool {
        if textField == self.textName {
            textField.resignFirstResponder()
            self.textID.becomeFirstResponder()
        }
        else if textField == self.textID {
            textField.resignFirstResponder()
            self.textPassword.becomeFirstResponder()
        }
        else if textField == self.textPassword {
            textField.resignFirstResponder()
            self.textNickname.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }

    @IBAction func buttonSave() {
        
      
        // 필요한 자료가 모두 입력 되었는지 확인
        if textID.text == "" {
        labelStatus.text = "ID를 입력하세요"; return;
        }
        if textPassword.text == "" {
            labelStatus.text = "Password를 입력하세요"; return;
        }
        if textName.text == "" {
            labelStatus.text = "사용자 이름을 입력하세요"; return;
        }
        if textNickname.text == "" {
            labelStatus.text = "화장대 별명을 입력하세요"; return;
        }
        let urlString: String =  "http://condi.swu.ac.kr/student/T04iphone/insertUser.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
       let restString: String = "id=" + textID.text! +  "&password=" + textPassword.text! + "&name=" + textName.text! + "&nickname=" + textNickname.text!
        request.httpBody = restString.data(using: .utf8)
        
        self.executeRequest(request: request)
       
    }
    
    
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
            }
            
            if let utf8Data = String(data: receivedData, encoding: .utf8) {
                DispatchQueue.main.async { // for Main Thread Checker
                self.labelStatus.text = utf8Data
                print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
                }
            }
        }
            task.resume()
    }
    
    @IBAction func buttonBack() {
        self.dismiss(animated: true, completion: nil)
    }
}
