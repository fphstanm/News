//
//  DataService.swift
//  News
//
//  Created by Philip on 26.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation
import RealmSwift

enum StoredData: String {
    case allSources = "allSources"
    case favoriteSources = "favoriteSources"
    case articlesOfFavoriteSources = "articlesOfFavoriteSources"
}

class RealmService {
    
    //MARK: Sources
    
    static func writeSources(_ sources: [Source]) {
        let realm = try! Realm()
        try! realm.write {
//            realm.delete(realm.objects(Source.self))
            realm.add(sources)
        }
    }
    
    static func readSources() -> [Source] {
        let realm = try! Realm()
        return Array(realm.objects(Source.self))
    }
    
    //MARK: Articles
    
    static func writeArticles(_ articles: [Article]) {
        let realm = try! Realm()
        try! realm.write {
//            realm.delete(realm.objects(Article.self))
            realm.add(articles)
        }
    }
    
    static func readArticles() -> [Article] {
        let realm = try! Realm()
        return Array(realm.objects(Article.self))
    }
    
    //TODO: - Write generic write read method for Object and Object Array
    //TODO: - Change deleting all to deleting filtered
}
