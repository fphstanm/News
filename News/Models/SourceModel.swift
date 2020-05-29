//
//  SourceModel.swift
//  News
//
//  Created by Philip on 04.04.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import Foundation
import RealmSwift

class Sources: Object, Codable {
    var sources: [Source]?
}

@objcMembers class Source: Object, Codable {
    dynamic var id: String?
    dynamic var name: String?
    dynamic var descr: String?
    dynamic var url: String?
    dynamic var category: String?
    dynamic var language: String?
    dynamic var country: String?
    
    dynamic var sourceType: String = SourceType.all.rawValue
    
    
    private enum CodingKeys : String, CodingKey {
        case descr = "description"
        case id, name, url, category, language, country
    }
}

