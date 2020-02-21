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
    private let characterService: HeroServiceProtocol = HeroKeeper()
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
            strongSelf.characterService.setHeroes(newHeroes: data)
            let listName = strongSelf.characterService.getAllHeroName()
            strongSelf.presenter.showHeroes(heroesNames: listName)
        }
    }
    
    func getHeroNameForCell(index: Int) -> String {
        return characterService.getHeroNameAtIndex(index: index)
    }
    
    func getHeroesCount() -> Int {
        return characterService.count
    }
    
    func getHeroByName(name: String) -> Hero? {
        return characterService.getHeroByName(name: name)
    }
    
    private func cancelSearch() {
        delayer.cancelTimerFire()
        networkManager.cancelCurrentRequest()
        characterService.setHeroes(newHeroes: nil)
    }
}
