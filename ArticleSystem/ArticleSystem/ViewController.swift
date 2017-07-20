//
//  ViewController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func pressSignIn(_ sender: Any) {
        
        let signInUser =  UserAccount(email: emailTextField.text!,password: passwordTextField.text! )

    }

}

