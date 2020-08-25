//
//  ArticleDetailsViewController.swift
//  News
//
//  Created by Philip on 25.08.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleDetailsViewController: BaseViewController {
    @IBOutlet private weak var articleTitle: UILabel!
    @IBOutlet private weak var articleDate: UILabel!
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var articleDescription: UILabel!
    //TODO: Add content?
    
    var article: Article?
    
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    //MARK: public methods
    
    func setup(with article: Article) {
        self.article = article
    }
    
    //MARK: - setup methods
    
    private func setupSubviews() {
        articleTitle.text = article?.title
        articleDescription.text = article?.descr
        articleDate.text = article?.author
        
        if let urlString = article?.urlToImage, let url = URL(string: urlString) {
            let imageResource = ImageResource(downloadURL: url)
            articleImage.kf.setImage(with: imageResource)
        }
    }
    
}
