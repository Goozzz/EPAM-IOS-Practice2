//
//  SearchInteractor.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol: class {
    
}

class SearchInteractor: SearchInteractorProtocol {
    private weak var presenter: SearchPresenterProtocol!
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
}
