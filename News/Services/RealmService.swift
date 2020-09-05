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
    
    
//    static func write<T: RealmCollectionValue>(_ object: T, classType: RealmCollectionValue.Type) {
//        let realm = try! Realm()
//        try! realm.write {
//            realm.delete(realm.objects(classType))
//            realm.add(object as! Object)
//        }
//    }

    
    
    //MARK: Favourite
    
//    static func writeFavouriteSources(_ sources: [String]) {
//        let realm = try! Realm()
//
//        let array = List<String>()
//        sources.forEach { array.append($0) }
//
//        let object = FavouriteSources()
//        object.sources = array
//
//        try! realm.write {
//            realm.delete(realm.objects(FavouriteSources.self))
//            realm.add(object)
//        }
//    }
//
//    static func readFavouriteSources() -> [String] {
//        let realm = try! Realm()
//        if !(realm.objects(FavouriteSources.self).isEmpty) {
//            let list = Array(realm.objects(FavouriteSources.self))[0].sources
//
//            let array = Array(list)
//            return array
//        }
//        return []
//    }
    
}
