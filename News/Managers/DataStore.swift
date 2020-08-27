//
//  DataStore.swift
//  News
//
//  Created by Philip on 04.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation
import RealmSwift

//DataManager
//NetworkService
//DataService
//DataStore

public enum SourceType: String {
    case all = "all"
    case favorite = "favorite"
}


class DataStore {
    
    private var allSources: [Source] = []
    private var articles: [Article] = []
    
    static let shared = DataStore()
    
    private init() {}
    
    
    //MARK: Sources
    
    func getSources(for scene: SourceType) -> [Source] {
        switch scene {
        case .all:
            return allSources
        case .favorite:
            let favoriteType = SourceType.favorite.rawValue
            return allSources.filter { $0.sourceType == favoriteType } //favoriteSources.contains($0.id ?? "") }
        }
    }
    
    func setAllSources(_ sources: [Source]) {
        allSources = formSourcesWithSavedFavoriteStatus(from: allSources, to: sources)
    }
    
    func changeTypeForSource(_ source: Source, _ type: SourceType) {
        let typeRowValue = type.rawValue
        let currentTypeEquealToFutureType = source.sourceType == typeRowValue //favoriteSources.contains(source.id ?? "")
        
        if !currentTypeEquealToFutureType {
            if let id = source.id {
                //костыль
                allSources.filter {
                    
                    if $0.id == id {
                        let newSource = source
                        let realm = try! Realm()
                        try! realm.write {
                            newSource.sourceType = typeRowValue
                        }
//                            let realm = try! Realm()
//                            try! realm.write {
//                    //            realm.delete(realm.objects(Article.self))
//                                $0.sourceType = typeRowValue
//                            }
                        
                    }
                    return true
                }
            }
        }
    }
    

    
    //MARK: Articles
    
    func getArticles() -> [Article] {
        return articles
    }
    
    func setArticles(_ articles: [Article]) {
        self.articles = articles
    }
    
    // MARK: - Private methods
    
    private func formSourcesWithSavedFavoriteStatus(from original: [Source], to new: [Source]) -> [Source] {
        let sourcesWithSavedFavorites = new
        original.forEach { source in
            let favoriteType = SourceType.favorite.rawValue
            if source.sourceType == favoriteType {
                sourcesWithSavedFavorites.forEach { resultSource in
                    if resultSource.id == source.id {
                        resultSource.sourceType = source.sourceType
                        return
                    }
                }
            }
        }
        
        return sourcesWithSavedFavorites
    }
    
}
