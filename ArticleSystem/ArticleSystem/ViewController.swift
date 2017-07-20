//
//  ViewController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class ViewController: UIViewController {

    var window: UIWindow?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func pressSignIn(_ sender: Any) {

        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    
                    Database.database().reference().child("users").observe(.childAdded, with: {
                        (snapshot) in
                        // childAdded逐筆呈現
                        if let userData = snapshot.value as? [String: String]{
                            if userData["useruid"] == user?.uid {
                            
                                currenyUserFirstName = userData["userFirstName"]!
                                currenyUserLastName = userData["userLastName"]!
                                currenyUserId = (user?.uid)!
                                
                                DispatchQueue.main.async {
                                    self.window = UIWindow(frame: UIScreen.main.bounds)
                                    self.window?.makeKeyAndVisible()
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let nc = storyboard.instantiateViewController(withIdentifier: "MainNav" )
                                    self.window?.rootViewController = nc
                                    
                                }
                                
                            }
                            
                        }
                        
                    }, withCancel: nil)
                    
                } else {
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
        

    }

}

