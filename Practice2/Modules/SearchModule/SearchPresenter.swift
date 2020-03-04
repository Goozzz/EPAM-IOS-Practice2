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
    
    func getHeaderForSection() -> String {
        let heroCount = interactor.getHeroesCount()
        if (heroCount > 0) {
            return "Search"
        } else {
            return "Recently"
        }
    }
    
    func getAllHeroes(searchText: String) {
        interactor.searchHeroesList(searchText: searchText)
    }
    
    func showHeroes(heroesNames: [String]) {
        viewController.updateSearchTableView()
    }
    
    func getHeroNameForCell(index: Int) -> String {
        return interactor.getHeroNameForCell(index: index)
    }
    
    func getRequestForCell(index: Int) -> String {
        return interactor.getRequestForCell(index: index)
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
        guard let hero = interactor.getHeroByName(name: name) else {
            return
        }
        
        destination.setHero(hero: hero)
        interactor.saveViewedHero(hero: hero)
    }
}
