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
    @IBOutlet private weak var favouriteButton: UIButton!
    
    var source: Source?
    
    var delegate: ChannelsListCellDelegate?
    
    
    func setup(_ source: Source) {
        name.text = source.name
        descr.text = source.descr
        
        self.source = source
    }
    
    func setupFavouriteOption(_ type: ChannelListType) {
        switch type {
        case .all:
            print("")
        case .favorite:
            print("")
            //addToFavoriteView.isHidden = true
        }
    }
    
    @IBAction func onFavouriteTapped(_ sender: Any) {
        delegate?.changeFavouriteStatus(self)
    }
}
