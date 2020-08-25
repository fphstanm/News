//
//  UIView.swift
//  News
//
//  Created by Philip on 25.08.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

extension UIView {
    func applyGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.yellow.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)

        layer.insertSublayer(gradient, at: 0)
    }
}

