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
    
    
    func setup(_ image: String, _ title: String, _ description: String) {
        ImageCache.default.memoryStorage.config.totalCostLimit = 1
        if ImageCache.default.isCached(forKey: image) {
            ImageCache.default.retrieveImage(forKey: image) { result in
                switch result {
                case .success(let value):
                    

                    let resource = ImageResource(downloadURL: URL(string: image)!, cacheKey: image)
                    self.newsImage.kf.setImage(with: resource)
//                    self.newsImage.kf.setimage

                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.newsImage.kf.setImage(with: URL(string: image))
        }
//        if let imageUrl = URL(string: image) {
//            let resource = ImageResource(downloadURL: URL(string: image)!, cacheKey: image)
//
//            self.newsImage.kf.setImage(with: resource)
//        }
        
        
        
//        self.newsImage.kf.setImage(with: URL(string: image),
//                                   progressBlock: { (re, to) in
//                                    print(re)
//        })
//        self.newsImage.kf.setImage(with: URL(string: image), placeholder: nil, options: nil, progressBlock: { (received, total) in
//            print("\(indexPath.item + 1): \(received)/\(total)")
//        }, completionHandler: nil)
        
        self.newsTitle.text = title
        self.newsDescription.text = description
    }
}
