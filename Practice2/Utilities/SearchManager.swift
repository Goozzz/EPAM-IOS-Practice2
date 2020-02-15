//
//  SearchManager.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchData {
    func search(searchText: String, dataHandler: () -> ());
}

class SearchManager: SearchData {
    private let networkManager: NetWorkManager
    
    init() {
        self.networkManager = NetWorkManager()
    }
    
    func search(searchText: String, dataHandler: () -> ()) {
        self.networkManager.searchCharacter(searchText: searchText, dataHandler: dataHandler)
    }
}
