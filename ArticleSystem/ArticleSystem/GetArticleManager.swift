//
//  GetArticleManager.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import Foundation
import Firebase

protocol ArticleManagerDelegate: class {
    func manager(_ controller: ArticleManager, articleArray: [Article])
}

class ArticleManager {
    
    var delegate: ArticleManagerDelegate? = nil
    
    func getArticle(){
        
        Database.database().reference().child("articles").observe(.value, with: {
            (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                var dataList: [Article] = [Article]()
                for item in snapshot.children {
                    
                    let data = Article(snapshot: item as! DataSnapshot)
                    
                    dataList.append(data)
                    
                }
                
                self.delegate?.manager(self, articleArray: dataList)
            }
            
        })
    }
    
}


