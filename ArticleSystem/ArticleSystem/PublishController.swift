//
//  PublishController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import Firebase

class PublishViewController: UIViewController {
    
    
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
        autherLabel.text = "Auther: \(currenyUserFirstName) \(currenyUserLastName)"
    }
    
    @IBAction func pressPublish(_ sender: Any) {
        
        let reference: DatabaseReference! = Database.database().reference().child("articles")
        // 新增節點資料
        var article: [String : String] = [String : String]()
        article["authorFirstName"] = currenyUserFirstName
        article["authorLastName"] = currenyUserLastName
        article["title"] = self.titleTextField.text
        article["content"] = self.contentTextField.text
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: Date())
        
        article["date"] = myString
        
        let articleRandomId = reference.childByAutoId()
        article["articleId"] = articleRandomId.key
        
        let userReference = reference.child(articleRandomId.key)
        userReference.updateChildValues(article) { (err, ref) in
            if err == nil{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNav")
                self.present(vc!, animated: true, completion: nil)
                return
            
            }
            
        }
        
        titleTextField.text = ""
        contentTextField.text = ""
        
        
        
        
    }
    
    
}

