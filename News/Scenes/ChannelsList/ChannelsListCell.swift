//
//  ChannelsListCell.swift
//  News
//
//  Created by Philip on 29.03.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

protocol ChannelsListCellDelegate {
    func changeFavouriteStatus(_ sender: ChannelsListCell)
}

class ChannelsListCell: UITableViewCell {
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var descr: UILabel!
    @IBOutlet private weak var favoriteIndicatingView: UIView?
    
    var source: Source?
    
    var delegate: ChannelsListCellDelegate?
    
    
    func setup(_ source: Source, isFavorite: Bool = false) {
        name.text = source.name
        descr.text = source.descr
        
        self.source = source
        
//        if isFavorite {
//            favoriteIndicatingView?.applyGradient()
//        }
    }
}
