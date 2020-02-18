//
//  SearchPresenter.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

class SearchPresenter: SearchPresenterProtocol {
    
    private weak var viewController: SearchViewControllerProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!
    
    init(viewController: SearchViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func getAllCharacters(searchText: String) {
        self.interactor.searchCharacterList(searchText: searchText)
    }
    
    func showCharacters(charactersName: [String]) {
        self.viewController.updateSearchTableView()
    }
    
    func prepareSearchTableViewCell(index: Int) -> String {
        return self.interactor.getNameForCell(index: index)
    }
    
    func getCharacterCount() -> Int {
        return self.interactor.getCharacterCount()
    }
    
    func characterCellSelected(sender: Any?) {
        self.router.showDetailView(sender: sender)
    }
    
    func prepareForShowDetailInfo(name: String, destination: DetailInfoViewController) {
        let character = self.interactor.getCharacterBy(name: name)
        destination.setChar(char: character)
    }
}
