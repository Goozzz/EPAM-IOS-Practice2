//
//  SearchPresenter.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

protocol SearchPresenterProtocol: class {
    var interactor: SearchInteractorProtocol! {set get}
    var router: SearchRouterProtocol! {set get}
    
    func getAllCharacters(searchText: String)
    func showCharacters(charactersName: [String])
    func prepareSearchTableViewCell(index: Int) -> String
    func getCharacterCount() -> Int
}

class SearchPresenter: SearchPresenterProtocol {
    
    private weak var _viewController: SearchViewControllerProtocol!
    private var _interactor: SearchInteractorProtocol!
    private var _router: SearchRouterProtocol!
    
    init(viewController: SearchViewControllerProtocol) {
        self._viewController = viewController
    }
    
    var interactor: SearchInteractorProtocol! {
        get {
            return self._interactor
        }
        set {
            self._interactor = newValue
        }
    }
    
    var router: SearchRouterProtocol! {
        get {
            return self._router
        }
        set {
            self._router = newValue
        }
    }
    
    func getAllCharacters(searchText: String) {
        self.interactor.searchCharacterList(searchText: searchText)
    }
    
    func showCharacters(charactersName: [String]) {
        self._viewController.updateSearchTableView()
    }
    
    func prepareSearchTableViewCell(index: Int) -> String {
        return self.interactor.getNameForCell(index: index)
    }
    
    func getCharacterCount() -> Int {
        return self.interactor.getCharacterCount()
    }
    
}
