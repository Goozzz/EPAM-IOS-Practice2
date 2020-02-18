//
//  ViewController.swift
//  Practice2
//
//  Created by Евгений Гусев on 12.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var starWarsSearchBar: UISearchBar!
    @IBOutlet weak var resultSearchTableView: UITableView!
    
    private var _presenter: SearchPresenterProtocol!
    private var _configurator: SearchConfiguratorProtocol = SearchConfigurator()
    
    var currentTask: URLSessionDataTask?
    let characterKeeper = CharacterKeeper()
    var searchManager: SearchDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _configurator.config(viewController: self)
        
        self.searchManager = SearchManager(request: SearchRequest(searchText: "", updater: self))

        starWarsSearchBar.delegate = self
        
        let starWarsCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        
        resultSearchTableView.register(starWarsCellNib, forCellReuseIdentifier: "SearchTableViewCell")
        resultSearchTableView.delegate = self
        resultSearchTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetailCharInformation") {
            if let cell = sender as? SearchTableViewCell,
                let name = cell.myLabel?.text,
                let destination = segue.destination as? DetailInfoViewController {
                let char = characterKeeper.findByName(name: name)
                destination.setChar(char: char)
            }
        }
    }
}

protocol SearchViewControllerProtocol: class {
    var presenter: SearchPresenterProtocol! {set get}
    
    func updateSearchTableView(dataList: [String])
}

protocol DataUpdater: class {
    func updateSearchTableView(charList: [Character]);
}

extension SearchViewController: DataUpdater {
    func updateSearchTableView(charList: [Character]) {
        characterKeeper.setCharacterList(charList: charList)
        DispatchQueue.main.async {
            self.resultSearchTableView.reloadData()
        }
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    var presenter: SearchPresenterProtocol! {
        get {
            return _presenter
        }
        set {
            self._presenter = newValue
        }
    }
    
    func updateSearchTableView(dataList: [String]) {
            
    }
    
    
    
}

