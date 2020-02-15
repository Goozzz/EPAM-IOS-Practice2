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
            if let cell = sender as? SearchTableViewCell,
                let name = cell.myLabel?.text,
                let destination = segue.destination as? DetailInfoViewController {
                let char = characterKeeper.findByName(name: name)
                destination.setChar(char: char)
            }
        }
    }
}

protocol DataUpdater: class {
    func updateSearchTableView(charList: [Character]);
}

extension ViewController: DataUpdater {
    func updateSearchTableView(charList: [Character]) {
        characterKeeper.setCharacterList(charList: charList)
        DispatchQueue.main.async {
            self.resultSearchTableView.reloadData()
        }
    }
}

