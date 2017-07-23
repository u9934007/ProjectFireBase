//
//  userStruct.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import Foundation
import Firebase

struct UserAccount {
    
    let email: String
    let password: String

}

struct Author {
    
    let firstName: String
    let lastName: String

}

struct Article {
    
    var articleId: String
    var authorFirstName: String
    var authorLastName: String
    var content: String
    var date: String
    var title: String
    
    init(snapshot: DataSnapshot){
        let snapshotValue: [String: AnyObject] = (snapshot.value as! [String: AnyObject])
        self.articleId = snapshot.key
        self.authorFirstName = snapshotValue["authorFirstName"]! as! String
        self.authorLastName = snapshotValue["authorLastName"]! as! String
        self.content = snapshotValue["content"]! as! String
        self.date = snapshotValue["date"]! as! String
        self.title = snapshotValue["title"]! as! String
    }
    
}

var like: [Article] = []

var currentUserFirstName = ""
var currentUserLastName = ""
var currentUserId = ""

