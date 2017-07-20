//
//  PublishController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    
    @IBAction func pressPublish(_ sender: Any) {
        
        let publishedArticle = Article(title:titleTextField.text!,
                                       content: contentTextField.text!,
                                       author: Author(firstName: currenyUserFirstName,
                                                      lastName:currenyUserLastName),
                                       publishDate: Date())
        
        titleTextField.text = ""
        contentTextField.text = ""
        
        
        
        
    }
    
    
}

