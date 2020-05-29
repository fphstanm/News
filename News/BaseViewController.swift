//
//  BaseViewController.swift
//  News
//
//  Created by Philip on 24.05.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }
    
    func showActivityIndicator() {
        activityView.startAnimating()
        activityView.isHidden = false
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
        self.activityView.isHidden = true
    }
}
