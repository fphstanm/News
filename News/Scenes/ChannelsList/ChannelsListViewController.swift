//
//  ViewController.swift
//  News
//
//  Created by Philip on 29.03.2020.
//  Copyright © 2020 Philip. All rights reserved.
//

import UIKit

enum ChannelListType: Int {
    case all = 0
    case favorite = 1
}

//TODO:
// - pagination
// - offline mode
// - image compressing

class ChannelsListViewController: UIViewController, UITabBarDelegate {

    @IBOutlet private weak var channelsTableView: UITableView!
    
    private lazy var refreshControl = UIRefreshControl()
            
    var sources: [Source] = []
    
    var scene = ChannelListType.all
    
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.channelsTableView.delegate = self
        self.channelsTableView.dataSource = self
        
        self.setupScene()
        self.setupSourcesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.scene == .favorite {
//            self.sources = Manager.shared.getFavouriteSources()
            Manager.shared.getFavoriteSources({ (sources) in
                self.sources = sources
                self.channelsTableView.reloadData()
            })
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
    }
    
    //MARK: Setup
    
    func setupScene() {
        switch self.tabBarController?.selectedIndex {
        case 0: self.scene = .all
        case 1: self.scene = .favorite
        default: self.scene = .all
        }
    }
    
    func setupSourcesData() {
        switch scene {
        case .all:
            self.setupRefreshControl()
            Manager.shared.getAllSources { sources in
               self.sources = sources
               self.channelsTableView.reloadData()
           }
        case .favorite: self.scene = .favorite
//            self.sources = Manager.shared.
//            self.sources = DataStore.shared.getSources(for: .favorite)
//            self.channelsTableView.reloadData()
            Manager.shared.getFavoriteSources({ (sources) in
                self.sources = sources
                self.channelsTableView.reloadData()
            })
        }
    }
    
    //MARK: RefreshControl
    
    func setupRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.channelsTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        self.sources = []
        self.channelsTableView.reloadData()
 
        Manager.shared.loadAllSources { sources in
            self.sources = sources
            sender.endRefreshing()
//            DataService.readFavouriteSources()
            self.channelsTableView.reloadData()
        }
    }
    
    
    @IBAction func showNewsButtonTapped(_ sender: Any) {
        RealmService.writeSources(DataStore.shared.getSources(for: .all))
        RealmService.writeArticles(DataStore.shared.getArticles())
    }
    
}


//MARK: TableView logic


extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.channelsTableView.dequeueReusableCell(withIdentifier: "channelCell") as! ChannelsListCell
        cell.setup(self.sources[indexPath.row])
        cell.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
}


//MARK: Cell delegate


extension ChannelsListViewController: ChannelsListCellDelegate {
    func changeFavouriteStatus(_ sender: ChannelsListCell) {
        
        DataStore.shared.changeTypeForSource(sender.source!, .favorite)
        
        switch self.scene {
        case .all: DataStore.shared.changeTypeForSource(sender.source!, .favorite) //TODO!
        case .favorite: DataStore.shared.changeTypeForSource(sender.source!, .all) //TODO!
        }
    }
}
    
