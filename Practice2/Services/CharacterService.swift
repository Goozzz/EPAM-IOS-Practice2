//
//  CharacterModel.swift
//  Practice2
//
//  Created by Евгений Гусев on 13.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol CharacterServiceProtocol {
    var count: Int {get}
    
    func getAllCharacterName() -> [String]
    func setCharacters(newCharacters: Data?)
    func getCharacterAtIndex(index: Int) -> Character
    func getCharacterNameAtIndex(index: Int) -> String
    func findByName(name: String) -> Character
}

class CharacterKeeper: CharacterServiceProtocol {
    private var characterList: [Character]?
    
    var count: Int {
        get {
            return self.characterList?.count ?? 0
        }
    }
    
    func findByName(name: String) -> Character {
        guard let list = self.characterList else {
            return Character()
        }
        for char in list {
            if char.name == name {
                return char
            }
        }
        
        return Character()
    }
    
    func getAllCharacterName() -> [String] {
        guard let list = self.characterList else {
            return []
        }
        var charactaresName: [String] = []
        
        for character in list {
            charactaresName.append(character.name)
        }
        
        return charactaresName
    }
    
    func setCharacters(newCharacters: Data?) {
        guard let data = newCharacters else {
            self.characterList = []
            return
        }
        
        if let charList = try?
            JSONDecoder().decode(CharacterList.self, from: data) {
            if(charList.charList.isEmpty) {
                self.characterList = []
            } else {
                self.characterList = charList.charList
            }
        }
    }
    
    func getCharacterAtIndex(index: Int) -> Character {
        return self.characterList?[index] ?? Character()
    }
    
    func getCharacterNameAtIndex(index: Int) -> String {
        return self.characterList?[index].name ?? ""
    }
}

