//
//  SearchInteractor.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol: class {
    func prepareCharacterList(searchText: String) -> [String]
    func getCharacterForCell(index: Int) -> Character
    func getNameForCell(index: Int) -> String
    func downloadCharacterList(searchText: String)
    func getCharacterCount() -> Int
}

class SearchInteractor: SearchInteractorProtocol {
    private weak var presenter: SearchPresenterProtocol!
    
    private let networkManager: NetworkServiceProtocol = NetWorkManager()
    private let characterService: CharacterServiceProtocol = CharacterKeeper()
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func prepareCharacterList(searchText: String) -> [String] {
        return []
    }
    
    func downloadCharacterList(searchText: String) {
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
    
}
