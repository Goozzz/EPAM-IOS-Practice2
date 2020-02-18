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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _configurator.config(viewController: self)

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
                self.presenter.prepareForShowDetailInfo(name: name, destination: destination)
            }
        }
    }
}

protocol SearchViewControllerProtocol: class {
    var presenter: SearchPresenterProtocol! {set get}
    
    func updateSearchTableView()
    func peformSegue(segueIdentifier: String, sender: Any?)
}

extension SearchViewController: SearchViewControllerProtocol {
    
    func peformSegue(segueIdentifier: String, sender: Any?) {
        self.performSegue(withIdentifier: segueIdentifier, sender: sender)
    }
    
    var presenter: SearchPresenterProtocol! {
        get {
            return _presenter
        }
        set {
            self._presenter = newValue
        }
    }
    
    func updateSearchTableView() {
        DispatchQueue.main.async {
            self.resultSearchTableView.reloadData()
        }
    }
}

