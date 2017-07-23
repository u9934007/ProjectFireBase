//
//  LikesManager.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import Foundation
import Firebase

protocol LikesManagerDelegate: class {
    func manager(_ controller: LikesManager, likeUsers: [String], articleId: String)
}

class LikesManager {
    
    var delegate: LikesManagerDelegate? = nil
    
    func getLikes(articleId: String){
        
        var likeUserArray: [String] = []
        
        Database.database().reference().child("likes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if !snapshot.hasChild(articleId){
            
                self.delegate?.manager(self, likeUsers: likeUserArray, articleId: articleId)
                return
            }
            
            
        })
        
        Database.database().reference().child("likes").child(articleId).observe(.childAdded, with: {
            (snapshot) in
            print(snapshot)
            if let userData = snapshot.value as? String{
                
                likeUserArray.append(userData)
                
            }
            
            self.delegate?.manager(self, likeUsers: likeUserArray, articleId: articleId)
            print(likeUserArray)
        })
   
    }
    
}


