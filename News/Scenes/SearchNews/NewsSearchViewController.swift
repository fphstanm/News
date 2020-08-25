//
//  SearchNewsViewController.swift
//  News
//
//  Created by Philip on 24.05.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class NewsSearchViewController: BaseViewController {
    
    @IBOutlet private weak var articlesTableView: UITableView!
    @IBOutlet private weak var articlesSearchBar: UISearchBar!
    
    private var artiles: [Article] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articlesSearchBar.delegate = self
        articlesSearchBar.becomeFirstResponder()
        
        setupTableView()
    }

    func setupTableView() {
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        
        articlesTableView.tableFooterView = UIView()
        articlesTableView.keyboardDismissMode = .interactive
    }
}


//MARK: TableView logic


extension NewsSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articlesTableView.dequeueReusableCell(withIdentifier: "NewsListCell") as! NewsListCell
        let article = artiles[indexPath.row]
        cell.setup(with: article)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}


//MARK: - SearchBar logic

extension NewsSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        articlesSearchBar.resignFirstResponder()
        searchArticles(by: text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            artiles = []
            articlesTableView.reloadData()
        } else {
            guard let text = searchBar.text else { return }
            searchArticles(by: text)
        }
    }
    
    private func searchArticles(by phrase: String) {
        showActivityIndicator()
        artiles = []
        articlesTableView.reloadData()
        
        NetworkService.getArticles(searchText: phrase) { [weak self] articles in
            self?.artiles = articles
            self?.articlesTableView.reloadData()
            self?.hideActivityIndicator()
        }
    }
}
