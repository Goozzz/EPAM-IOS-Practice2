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
        self.presenter.getAllCharacters(searchText: searchText)
    }
}
