//
//  NetworkService.swift
//  News
//
//  Created by Philip on 04.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import RealmSwift

enum ApiRoute {
    case sources
    case articles
    
    var path: String {
        switch self {
        case .sources: return "sources"
        case .articles: return "top-headlines"
        }
    }
    
    func url() -> String {
        let base = NetworkService.baseUrl
        let apiKey = "apiKey=" + NetworkService.apiKey
        return base + path + "?" + apiKey
    }
}

class NetworkService {
    
    //21cacbba225c428583b807fe6a5971c1
    
    static let baseUrl = "https://newsapi.org/v2/"
    static let apiKey = "21cacbba225c428583b807fe6a5971c1"
    
    
    static let articlesua = "https://newsapi.org/v2/top-headlines?country=us&apiKey=21cacbba225c428583b807fe6a5971c1"
    static let sourcesUA = "https://newsapi.org/v2/sources?language=en&country=us&apiKey=21cacbba225c428583b807fe6a5971c1"
    
    
//    https://newsapi.org/v2/top-headlines?q=trump&apiKey=API_KEY
    
    static func getArticles(_ sourcesIDs: [String] = [], searchText: String? = nil, _ completion: @escaping (([Article]) -> ())) {
        var url = "https://newsapi.org/v2/top-headlines?apiKey=21cacbba225c428583b807fe6a5971c1" //+ "&sources=Nbcsports.com,Deadline.com"
        
        
        if let text = searchText {
            url += "&q=\(text)"
        }
        
        if !sourcesIDs.isEmpty {
            var query = "&sources="
            let joined = sourcesIDs.joined(separator: ",")
            
            query += joined
            
            url += query
        }
        
        SessionManager.default.request(url)
            .responseString { (jsonString) in
                if let jsonData = jsonString.result.value?.data(using: .utf8) {
                    let user = try! JSONDecoder().decode(Articles.self, from: jsonData)
                    if let articles = user.articles {
                        DataStore.shared.setArticles(articles)
                        completion(articles)
                    } else {
                        completion([])
                    }
                    //костыль
                } else {
                    completion([])
                }
                
        }
    }
    
    
    static func getSources(_ completion: @escaping (([Source]) -> ())) {
        SessionManager.default.request(sourcesUA)
            .responseString(completionHandler: { (response) in
                if let jsonData = response.result.value?.data(using: .utf8) {
                    let sources = try! JSONDecoder().decode(Sources.self, from: jsonData)
                    completion(sources.sources ?? [])
                }
        })
    }
    
    static func isInternetConnectionAvailable() -> Bool {
        NetworkReachabilityManager()?.isReachable ?? false
    }
    
    //    func get(at route: ApiRoute) -> DataRequest {
    //        return request(route, method: .get, encoding: URLEncoding.default)
    //    }
    //
    //    func request(at route: ApiRoute, method: HTTPMethod, params: Parameters = [:], encoding: ParameterEncoding) -> DataRequest {
    //        let url = route.url()
    //        return Alamofire
    //            .request(url, method: method, parameters: params, encoding: encoding)
    //            .validate()
    //    }
        
}
