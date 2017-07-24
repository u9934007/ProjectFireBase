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
        cell.likebutton.layer.cornerRadius = 4
        cell.likebutton.layer.borderColor = UIColor.gray.cgColor
        cell.likebutton.layer.borderWidth = 0.2
        cell.likebutton.tintColor = UIColor.gray
        
        for article in userlikedArticles{
            
            if article == articleArrays[indexPath.row].articleId{
                cell.likebutton.tintColor = UIColor.blue
                cell.likebutton.layer.borderColor = UIColor.blue.cgColor
            }
        
        }
        
        cell.likebutton.tag = indexPath.row
        cell.likebutton.addTarget(self, action: #selector(handlelike), for: .touchUpInside)
        
        self.myTableView.estimatedRowHeight = 100
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        return cell

    }
    
    func handlelike(sender: UIButton){
        
        if sender.tintColor == UIColor.blue{
            
            handledislike(sender: sender)
            
            var count = 0
            for article in userlikedArticles{
                
                if article == articleArrays[sender.tag].articleId {
                    
                    userlikedArticles.remove(at: count)
                    
                }
                count += 1
            }
            
        
        } else {
            
            let reference: DatabaseReference! = Database.database().reference().child("likes")
            
            // 新增節點資料
            var like: [String : String] = [String : String]()
            like[currentUserId] = currentUserId
            
            let likeReference = reference.child(articleArrays[sender.tag].articleId)
            
            likeReference.updateChildValues(like) { (err, ref) in
                if err == nil{
                    
                    print("like!")
                    sender.tintColor = UIColor.blue
                    self.likesManager.getLikes(articleId:self.articleArrays[sender.tag].articleId)
                }
                
            }
            
        }
        
    }
    
    func handledislike(sender: UIButton){
        
        let reference: DatabaseReference! = Database.database().reference().child("likes").child(articleArrays[sender.tag].articleId)
        
        
        let likeReference = reference.child(currentUserId)
        
        likeReference.removeValue() { (err, ref) in
            if err == nil{
                
                print("dislike!")
                sender.tintColor = UIColor.gray
                self.likesManager.getLikes(articleId:self.articleArrays[sender.tag].articleId)
                
            }
            
        }
    
    }
    
    
    
    func manager(_ controller: LikesManager, likeUsers: [String], articleId: String){
        
        likesOfArticle.updateValue( likeUsers.count, forKey: articleId)
        
        for id in likeUsers {
            
            var ok = true
            
            for article in userlikedArticles {
            
                if article == articleId {
                    ok = false
                }
            
            }
            
            if id == currentUserId && ok {
                
                userlikedArticles.append(articleId)
            
            }
        }
        
        myTableView.reloadData()
    }
    

}

