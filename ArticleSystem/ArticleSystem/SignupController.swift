//
//  SignupController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        
    }
    
    
    @IBAction func pressOK(_ sender: Any) {
        
        
        let signupUser = UserAccount(email: emailTextField.text!,password: passwordTextField.text! )
        
    }
    
}

