//
//  AriticlesController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit
import Firebase

class ArticlesViewController: UIViewController, ArticleManagerDelegate,UITableViewDelegate, UITableViewDataSource ,LikesManagerDelegate {
    
    let likesManager = LikesManager()
    let articleManager = ArticleManager()
    
    @IBOutlet weak var myTableView: UITableView!
    
    var articleArrays: [Article] = []
    var userlikedArticles: [String] = []
    var likesOfArticle: [String: Int] = [:]

     override func viewDidLoad() {
        

        articleManager.delegate = self
        articleManager.getArticle()
        likesManager.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        myTableView.reloadData()

    }
    
    func manager(_ controller: ArticleManager, articleArray: [Article]){
        
        self.articleArrays = articleArray
        
        for articles in articleArray{
            likesManager.getLikes(articleId: articles.articleId)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articleArrays.count
    }
    
    //UITableViewDataSource - public
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        cell.contentLabel.text = "\(articleArrays[indexPath.row].content)"
        cell.dateLabel.text = "Date: \(articleArrays[indexPath.row].date)"
        cell.titleLabel.text = "Title: \(articleArrays[indexPath.row].title)"
        cell.authorLabel.text = "Author: \(articleArrays[indexPath.row].authorFirstName) \(articleArrays[indexPath.row].authorLastName)"
        
        let likes = likesOfArticle[articleArrays[indexPath.row].articleId]
        
        
        cell.likesLabel.text = String(describing: likes ?? 0)
        return cell

    }
    
    func manager(_ controller: LikesManager, likeUsers: [String], articleId: String){
        
        likesOfArticle.updateValue( likeUsers.count, forKey: articleId)
        
        for id in likeUsers {
            
            if id == currenyUserId{
                
                userlikedArticles.append(articleId)
            
            }
        }
        
        myTableView.reloadData()
    }
    

}

