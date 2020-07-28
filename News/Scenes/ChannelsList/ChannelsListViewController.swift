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
        
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        
        setupScene()
        setupSourcesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if scene == .favorite {
//            sources = Manager.shared.getFavouriteSources()
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
        switch tabBarController?.selectedIndex {
        case 0: scene = .all
        case 1: scene = .favorite
        default: scene = .all
        }
    }
    
    func setupSourcesData() {
        switch scene {
        case .all:
            setupRefreshControl()
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
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        channelsTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        sources = []
        channelsTableView.reloadData()
 
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
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = channelsTableView.dequeueReusableCell(withIdentifier: "channelCell") as! ChannelsListCell
        cell.setup(sources[indexPath.row])
        cell.tag = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let source = sources[indexPath.row]
        let isSourceFavourite = DataStore.shared.getSources(for: .favorite).contains(source)
        
        let addToFavoriteColor = isSourceFavourite ? .lightGray : #colorLiteral(red: 1, green: 0.7768199313, blue: 0.001346542883, alpha: 1)
        let addToFavoriteTitle = isSourceFavourite ? "Added" : "Add to favorite"
        let addToFavoriteAction = UITableViewRowAction(style: .normal, title: addToFavoriteTitle) { rowAction, indexPath in
            if !isSourceFavourite {
                DataStore.shared.changeTypeForSource(source, .favorite)
            }
        }

        addToFavoriteAction.backgroundColor = addToFavoriteColor
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { [weak self] rowAction, indexPath in
            self?.sources.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
            
        }
        deleteAction.backgroundColor = .red
        
        var actions: [UITableViewRowAction] = []
        
        switch scene {
        case .all: actions.append(addToFavoriteAction)
        case .favorite: actions.append(deleteAction)
        }
        
        return actions
    }
}


//MARK: Cell delegate


extension ChannelsListViewController: ChannelsListCellDelegate {
    func changeFavouriteStatus(_ sender: ChannelsListCell) {
        
        DataStore.shared.changeTypeForSource(sender.source!, .favorite)
        
        switch scene {
        case .all:
            DataStore.shared.changeTypeForSource(sender.source!, .favorite) //TODO!
        case .favorite:
            DataStore.shared.changeTypeForSource(sender.source!, .all) //TODO!
            
        }
    }
}
    
