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
    
    var currentTask: URLSessionDataTask?
    let characterKeeper = CharacterKeeper()
    let searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        starWarsSearchBar.delegate = self
        
        let starWarsCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        
        resultSearchTableView.register(starWarsCellNib, forCellReuseIdentifier: "SearchTableViewCell")
        resultSearchTableView.delegate = self
        resultSearchTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetailCharInformation") {
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String) {
        
        let searchRequest = SearchRequest(searchText: searchText, handler: updateSearchTableView(charList:))
        searchManager.search(request: searchRequest)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterKeeper.getCharacterlist().count
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
        cell.prepareForAppear(text: characterKeeper.getCharNameAtIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "showDetailCharInformation", sender: tableView.cellForRow(at: indexPath))
    }
}

extension ViewController {
    func updateSearchTableView(charList: [Character]) {
        characterKeeper.setCharacterList(charList: charList)
        DispatchQueue.main.async {
            self.resultSearchTableView.reloadData()
        }
    }
}

