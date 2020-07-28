//
//  NewsListViewController.swift
//  News
//
//  Created by Philip on 19.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit
import RealmSwift

class NewsListViewController: UIViewController {
    @IBOutlet private weak var newsTableView: UITableView!
    
    private lazy var refreshControl = UIRefreshControl()

    var articles: [Article] = []
    
    let tempImage = "https://www.bigstockphoto.com/images/homepage/module-6.jpg"
    
    override func viewDidLoad() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        setupRefreshControl()
        handleArticles()
    }
    
    func handleArticles() {
        let realm = try! Realm()
        let articles = Array(realm.objects(Article.self))
        self.articles = articles
        
//        if articles.isEmpty {
        Manager.shared.getFavoriteArticles() { articles in 
            self.articles = DataStore.shared.getArticles()
            self.newsTableView.reloadData()
        }

    }
    
    //MARK: RefreshControl

    func setupRefreshControl() {
       refreshControl = UIRefreshControl()
       refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
       newsTableView.refreshControl = refreshControl
    }

    @objc func refreshData(_ sender: UIRefreshControl) {
        articles = []
        newsTableView.reloadData()
        
        NetworkService.getArticles { articles in
           self.articles = articles
           sender.endRefreshing()
           self.newsTableView.reloadData()
       }
    }
    
}

//MARK: TableView logic

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsListCell") as! NewsListCell
        let article = articles[indexPath.row]
        cell.setup(with: article)
        
        return cell
    }
    
}
