//
//  SignupController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func pressOK(_ sender: Any) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
            
            
        } else if firstNameTextField.text == "" || lastNameTextField.text == "" {
        
            let alertController = UIAlertController(title: "Error", message: "Please enter your Name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        
        } else {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error != nil {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                
                let useruid = user?.uid
                
                let reference: DatabaseReference! = Database.database().reference().child("users")
                // 新增節點資料
                var userData: [String : String] = [String : String]()

                userData["userFirstName"] = self.firstNameTextField.text!
                userData["userLastName"] = self.lastNameTextField.text!

                let userReference = reference.child(useruid!)
                
                userReference.updateChildValues(userData) { (err, ref) in
                    if err == nil{
                        
                        
                        print("Signed up success!")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInPage")
                        self.present(vc!, animated: true, completion: nil)
                        return
                    }
                
                }
                
            }
        }
        
        
        
    }
    
}

