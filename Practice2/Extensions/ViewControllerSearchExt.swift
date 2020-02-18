//
//  ViewControllerSearchExt.swift
//  Practice2
//
//  Created by Евгений Гусев on 16.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String) {
        if (searchText == "") {
            self.characterKeeper.setCharacterList(charList: [])
            self.resultSearchTableView.reloadData()
            return
        }
        
//        let searchRequest = SearchRequest(searchText: searchText, updater: self)
//        self.searchManager?.searchCharacterList(request: searchRequest)
        
        self.presenter.getAllCharacters(searchText: searchText)
    }
}
