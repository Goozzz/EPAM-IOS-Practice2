//
//  ViewController.swift
//  Practice2
//
//  Created by Евгений Гусев on 12.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, SearchViewControllerProtocol {
    
    @IBOutlet weak var starWarsSearchBar: UISearchBar!
    @IBOutlet weak var resultSearchTableView: UITableView!
    
    private var configurator: SearchConfiguratorProtocol = SearchConfigurator()
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.config(viewController: self)

        starWarsSearchBar.delegate = self
        
        let starWarsCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        resultSearchTableView.register(starWarsCellNib, forCellReuseIdentifier: "SearchTableViewCell")
        resultSearchTableView.delegate = self
        resultSearchTableView.dataSource = self
    }
    
    func performSegue(segueIdentifier: String, sender: Any?) {
        performSegue(withIdentifier: segueIdentifier, sender: sender)
    }
    
    func updateSearchTableView() {
        DispatchQueue.main.async {
            self.resultSearchTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetailCharInformation") {
            if let cell = sender as? SearchTableViewCell,
                let name = cell.myLabel?.text,
                let destination = segue.destination as? DetailInfoViewController {
                presenter.prepareForShowDetailInfo(name: name, destination: destination)
            }
        }
    }
}





