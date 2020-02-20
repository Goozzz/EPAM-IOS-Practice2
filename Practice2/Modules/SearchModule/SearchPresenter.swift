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
    
    func getAllHeroes(searchText: String) {
        interactor.searchHeroesList(searchText: searchText)
    }
    
    func showHeroes(heroesNames: [String]) {
        viewController.updateSearchTableView()
    }
    
    func prepareSearchTableViewCell(index: Int) -> String {
        return interactor.getHeroNameForCell(index: index)
    }
    
    func getHeroesCount() -> Int {
        return interactor.getHeroesCount()
    }
    
    func heroCellSelected(sender: Any?) {
        router.showDetailView(sender: sender)
    }
    
    func prepareForShowDetailInfo(name: String, destination: DetailInfoViewController) {
        let character = interactor.getHeroByName(name: name)
        destination.setHero(hero: character)
    }
}
