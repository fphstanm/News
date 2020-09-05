//
//  UIViewController.swift
//  News
//
//  Created by Philip on 03.09.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

extension UIViewController {
    func initControllerFromStoryboard(of type: UIViewController.Type) -> UIViewController? {
        let className = String(describing: type)
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: className)
        
        return controller
    }
}
