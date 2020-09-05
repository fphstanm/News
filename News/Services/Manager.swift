//
//  Manager.swift
//  News
//
//  Created by Philip on 26.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation

//TODO: background Thread

typealias Completion<T> = ([T]) -> ()

class Manager {
    static let shared = Manager()
    
    private init() {}
    
    //MARK: Sources
    
    func getAllSources(_ completion: @escaping (([Source]) -> ())) {
        
        let isSourcesLoadadedInCurrentSession = !(DataStore.shared.getSources(for: .all).isEmpty)
        let isSourcesSavedInDataBase = !(RealmService.readSources().isEmpty)
        
        if DataStore.shared.getSources(for: .all).isEmpty {
            if RealmService.readSources().isEmpty {
                NetworkService.getSources { sources in
                    DataStore.shared.setAllSources(sources)
                    completion(sources)
                }
            } else {
                let sources = RealmService.readSources()
                DataStore.shared.setAllSources(sources)
                completion(sources)
            }
        } else {
            completion([])
        }
    }
    
    func getFavoriteSources(_ completion: @escaping (([Source]) -> ())) {
        completion(DataStore.shared.getSources(for: .favorite))
    }
    
    func loadAllSources(_ completion: @escaping (([Source]) -> ())) {
        NetworkService.getSources { sources in
            DataStore.shared.setAllSources(sources)
            completion(sources)
        }
    }

    //MARK: Articles
    
    func getArticles() -> [Article] {
        return RealmService.readArticles()
    }
    
    //TODO: переписать под универсальный метод, который принимает айдишки
    func getFavoriteArticles(_ completion: @escaping (([Article]) -> ())) {
        
        let favoriteSources = DataStore.shared.getSources(for: .favorite)
        var favoriteSourcesIDs: [String] = []
        favoriteSources.forEach {
            if let id = $0.id {
                favoriteSourcesIDs.append(id)
            }
        }
        
        NetworkService.getArticles(favoriteSourcesIDs) { (articles) in
            DataStore.shared.setArticles(articles)
            completion(articles)
        }
        
    }
    
    func getArticles(from sources: [Source], _ completion: @escaping (([Article]) -> ())) {
        var sourcesIDs: [String] = []
        sources.forEach {
            guard let id = $0.id else { return }
            sourcesIDs.append(id)
        }
        
        NetworkService.getArticles(sourcesIDs) { [weak self] (articles) in
            completion(articles)
        }
    }

    func SaveAll() {
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
//        DataService.writeFavouriteSources(DataStore.shared.favoriteSources)
    }
    
    func isInternetConnectionAvailable() -> Bool {
        return NetworkService.isInternetConnectionAvailable()
    }
}
