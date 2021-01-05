//
//  SceneDelegate.swift
//  News
//
//  Created by Philip on 29.03.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    

    func sceneDidEnterBackground(_ scene: UIScene) {
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
        RealmService.writeArticles(DataStore.shared.getArticles())
    }

}

