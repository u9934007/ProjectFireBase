//
//  AriticlesController.swift
//  ArticleSystem
//
//  Created by 楊采庭 on 2017/7/20.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    

    @IBOutlet weak var myTableView: UITableView!
    var articleArray: [Article] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        myTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return articleArray.count
    }
    
    //UITableViewDataSource - public
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        return cell

    }

    

}

