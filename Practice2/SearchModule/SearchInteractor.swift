//
//  SearchInteractor.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol: class {
    func prepareCharacterList(searchText: String) -> [String]
}

class SearchInteractor: SearchInteractorProtocol {
    private weak var presenter: SearchPresenterProtocol!
    //private var searchManager: SearchDataProtocol = SearchManager()
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func prepareCharacterList(searchText: String) -> [String] {
        return []
    }
}
