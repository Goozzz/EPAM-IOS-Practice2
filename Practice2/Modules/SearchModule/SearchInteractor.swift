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
    private let characterService: CharacterServiceProtocol = CharacterKeeper()
    private var delayer: SearchDelayerProtocol = SearchDelayer()
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func searchCharacterList(searchText: String) {
        if (searchText == "") {
            self.cancelSearch()
            self.presenter.showCharacters(charactersName: [])
        }
        delayer.config(delayedFunc: self.downloadCharacterList(searchText:), data: searchText)
        delayer.call()
    }
    
    private func downloadCharacterList(searchText: String) {
        self.networkManager.getAllCharacters(searchText: searchText) { (data) in
            self.characterService.setCharacters(newCharacters: data)
            let listName = self.characterService.getAllCharacterName()
            self.presenter.showCharacters(charactersName: listName)
        }
    }
    
    func getCharacterForCell(index: Int) -> Character {
        return self.characterService.getCharacterAtIndex(index: index)
    }
    
    func getNameForCell(index: Int) -> String {
        return self.characterService.getCharacterNameAtIndex(index: index)
    }
    
    func getCharacterCount() -> Int {
        return self.characterService.count
    }
    
    func getCharacterBy(name: String) -> Character {
        return self.characterService.findByName(name: name)
    }
    
    private func cancelSearch() {
        self.delayer.cancelTimerFire()
        self.networkManager.cancelCurrentRequest()
        self.characterService.setCharacters(newCharacters: nil)
    }
}
