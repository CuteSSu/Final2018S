//
//  ViewController.swift
//  Bcosmetic
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginUserid: UITextField!
    @IBOutlet var loginPassword: UITextField!
    @IBOutlet var labelStatus: UILabel!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.loginUserid {
            textField.resignFirstResponder()
            self.loginPassword.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginPressed() {
      
        if loginUserid.text == "" {
            labelStatus.text = "ID를 입력하세요"; return;
        }
        if loginPassword.text == "" {
            labelStatus.text = "비밀번호를 입력하세요"; return;
        }
        
        let urlString: String = "http://condi.swu.ac.kr/student/T04iphone/loginUser.php"
        guard let requestURL = URL(string: urlString) else {
            return
        }
        
        self.labelStatus.text = " "
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let restString: String = "userid=" + loginUserid.text! + "&passwd=" + loginPassword.text!
        request.httpBody = restString.data(using: .utf8)
       
        let session = URLSession.shared
        let task = session.dataTask(with: request){ (responseData, response, responseError) in
            guard responseError == nil else{
                print("Error: calling POST")
                return
            }
            guard let receivedData = responseData else{
                print("Error: not receiving Data")
                return
            }
            
            do{
                let response = response as! HTTPURLResponse
                if !(200...299 ~= response.statusCode){
                    print(response.statusCode)
                    return
                }
                guard let jsonData = try JSONSerialization.jsonObject(with: receivedData, options: .allowFragments) as? [String: Any] else{
                    print("JSON Serialization Error!")
                    return
                }
                guard let success = jsonData["success"] as! String! else {
                    print("Error: PHP failure(success)")
                    return
                }
                if success == "YES"{
                    if let name = jsonData["name"] as! String! {
                        DispatchQueue.main.async{
                            self.performSegue(withIdentifier: "toLoginSuccess", sender: self) }
                        }
                    }
                else{
                    if let errMessage = jsonData["error"] as! String!{
                        DispatchQueue.main.async{
                            self.labelStatus.text = errMessage }
                        }
                    }
            }catch{
                print("Error: \(error)")
            }
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

