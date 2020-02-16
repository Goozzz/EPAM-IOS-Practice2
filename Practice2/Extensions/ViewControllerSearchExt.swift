//
//  ViewControllerSearchExt.swift
//  Practice2
//
//  Created by Евгений Гусев on 16.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String) {
        if (searchText == "") {
            self.characterKeeper.setCharacterList(charList: [])
            self.searchManager.cancelSearch()
            self.resultSearchTableView.reloadData()
            return
        }
        
        let searchRequest = SearchRequest(searchText: searchText, updater: self)
        self.searchManager.search(request: searchRequest)
    }
}
