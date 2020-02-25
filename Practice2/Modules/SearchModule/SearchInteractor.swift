//
//  SearchInteractor.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

class SearchInteractor: SearchInteractorProtocol {
    private weak var presenter: SearchPresenterProtocol!
    
    private let networkManager: NetworkServiceProtocol = NetWorkManager()
    private let heroService: HeroServiceProtocol = HeroKeeper()
    private var delayer: SearchDelayerProtocol = SearchDelayer()
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func searchHeroesList(searchText: String) {
        if (searchText.isEmpty) {
            cancelSearch()
            presenter.showHeroes(heroesNames: [])
            return
        }
        delayer.config(delayedFunc: downloadCharacterList(searchText:), data: searchText)
        delayer.call()
    }
    
    private func downloadCharacterList(searchText: String) {
        networkManager.getAllCharacters(searchText: searchText) { [weak self] (data) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.heroService.setHeroes(newHeroes: data)
            let listName = strongSelf.heroService.getAllHeroName()
            strongSelf.presenter.showHeroes(heroesNames: listName)
        }
    }
    
    func getHeroNameForCell(index: Int) -> String {
        return heroService.getHeroNameAtIndex(index: index)
    }
    
    func getRequestForCell(index: Int) -> String {
        return networkManager.getPreviousRequestsAtIndex(index: index)
    }
    
    func getHeroesCount() -> Int {
        return heroService.count
    }
    
    func getRequestsCount() -> Int {
        return networkManager.getPreviousRequestsCount()
    }
    
    func getHeroByName(name: String) -> Hero? {
        return heroService.getHeroByName(name: name)
    }
    
    func deleteRequest(index: Int) {
        networkManager.deleteRequest(index: index)
    }
    
    private func cancelSearch() {
        delayer.cancelTimerFire()
        networkManager.cancelCurrentRequest()
        heroService.setHeroes(newHeroes: nil)
    }
}
