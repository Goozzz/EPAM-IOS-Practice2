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
        if (searchText == "") {
            self.cancelSearch()
            self.presenter.showHeroes(heroesNames: [])
            return
        }
        delayer.config(delayedFunc: self.downloadCharacterList(searchText:), data: searchText)
        delayer.call()
    }
    
    private func downloadCharacterList(searchText: String) {
        self.networkManager.getAllCharacters(searchText: searchText) { (data) in
            self.characterService.setHeroes(newHeroes: data)
            let listName = self.characterService.getAllHeroName()
            self.presenter.showHeroes(heroesNames: listName)
        }
    }
    
    func getHeroForCell(index: Int) -> Hero {
        return self.characterService.getHeroAtIndex(index: index)
    }
    
    func getHeroNameForCell(index: Int) -> String {
        return self.characterService.getHeroNameAtIndex(index: index)
    }
    
    func getHeroesCount() -> Int {
        return self.characterService.count
    }
    
    func getHeroByName(name: String) -> Hero {
        return self.characterService.getHeroByName(name: name)
    }
    
    private func cancelSearch() {
        self.delayer.cancelTimerFire()
        self.networkManager.cancelCurrentRequest()
        self.characterService.setHeroes(newHeroes: nil)
    }
}
