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
    
    private var isEnableSearch = false
    
    init(viewController: SearchViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func isEnableSearchMode() -> Bool {
        return isEnableSearch
    }
    
    func getHeaderForSection() -> String {
        if (isEnableSearchMode()) {
            return "Search"
        } else {
            return "Recently"
        }
    }
    
    func getAllHeroes(searchText: String) {
        if (searchText.isEmpty) {
            isEnableSearch = false
            viewController.updateSearchTableView()
        } else {
            isEnableSearch = true
        }
        
        interactor.searchHeroesList(searchText: searchText)
    }
    
    func showHeroes(heroesNames: [String]) {
        viewController.updateSearchTableView()
    }
    
    func prepareSearchTableViewCell(index: Int) -> String {
        if (isEnableSearchMode()) {
            return interactor.getHeroNameForCell(index: index)
        } else {
            return interactor.getRequestForCell(index: index)
        }
    }
    
    func getHeroesCount() -> Int {
        return interactor.getHeroesCount()
    }
    
    func getRequestsCount() -> Int {
        return interactor.getRequestsCount()
    }
    
    func deleteRequest(index: Int) {
        interactor.deleteRequest(index: index)
        viewController.updateSearchTableView()
    }
    
    func heroCellSelected(sender: Any?) {
        router.showDetailView(sender: sender)
    }
    
    func prepareForShowDetailInfo(name: String, destination: DetailInfoViewController) {
        let character = interactor.getHeroByName(name: name)
        destination.setHero(hero: character)
    }
}
