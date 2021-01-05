//
//  NewsListCell.swift
//  News
//
//  Created by Philip on 19.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit
import Kingfisher

class NewsListCell: UITableViewCell {
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var newsDescription: UILabel!
    
    
    func setup(with article: Article) {
        
        newsTitle.text = article.title
        newsDescription.text = article.descr
        
        guard let imageUrlString = article.urlToImage else { return }
        setupImage(imageUrlString: imageUrlString)
    }
    
    
    private func setupImage(imageUrlString: String) {
                ImageCache.default.memoryStorage.config.totalCostLimit = 1
                if ImageCache.default.isCached(forKey: imageUrlString) {
                    ImageCache.default.retrieveImage(forKey: imageUrlString) { result in
                        switch result {
                        case .success(_):
                            let resource = ImageResource(downloadURL: URL(string: imageUrlString)!, cacheKey: imageUrlString)
                            self.newsImage.kf.setImage(with: resource)
                        case .failure(let error):
                            print(error)
                        }
                    }
                } else {
                    self.newsImage.kf.setImage(with: URL(string: imageUrlString))
                }
    }
}
