//
//  userStruct.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import Foundation

struct UserAccount {
    
    let email: String
    let password: String

}

struct Author {
    
    let firstName: String
    let lastName: String

}

struct Article {
    
    let title: String
    let content: String
    let author: Author
    let publishDate: Date

}

var like: [Article] = []


var currenyUserFirstName = ""
var currenyUserLastName = ""
