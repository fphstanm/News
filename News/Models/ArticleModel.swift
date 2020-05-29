//
//  ArticleModel.swift
//  News
//
//  Created by Philip on 19.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation
import RealmSwift

class Articles: Object, Codable {
    var status: String?
    var totalResult: Int?
    var articles: [Article]?
}

@objcMembers class Article: Object, Codable {
    dynamic var source: SourceInfo?
    dynamic var author: String?
    dynamic var title: String?
    dynamic var descr: String?
    dynamic var url: String?
    dynamic var urlToImage: String?
    dynamic var publishedAt: String?
    dynamic var content: String?
    
    private enum CodingKeys : String, CodingKey {
        case descr = "description"
        case source, author, title, url, urlToImage, publishedAt, content
    }
}

@objcMembers class SourceInfo: Object, Codable {
    dynamic var id: String?
    dynamic var name: String?
}
