//
//  ViewController.swift
//  Practice2
//
//  Created by Евгений Гусев on 12.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var starWarsSearchBar: UISearchBar!
    @IBOutlet weak var resultSearchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        starWarsSearchBar.delegate = self
        
        let starWarsCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        
        resultSearchTableView.register(starWarsCellNib, forCellReuseIdentifier: "SearchTableViewCell")
        resultSearchTableView.delegate = self
        resultSearchTableView.dataSource = self
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:
        String) {
        resultSearchTableView.reloadData()
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Search"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "SearchTableViewCell", for: indexPath)
            as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.prepareForAppear(text: "Bob")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

