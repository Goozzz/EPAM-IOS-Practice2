//
//  CharacterModel.swift
//  Practice2
//
//  Created by Евгений Гусев on 13.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

struct Character: Codable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case height = "height"
        case mass = "mass"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender = "gender"
    }
    
    init() {
        self.name = ""
        self.height = ""
        self.mass = ""
        self.hairColor = ""
        self.skinColor = ""
        self.eyeColor = ""
        self.birthYear = ""
        self.gender = ""
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.height = try valueContainer.decode(String.self, forKey: CodingKeys.height)
        self.mass = try valueContainer.decode(String.self, forKey: CodingKeys.mass)
        self.hairColor = try valueContainer.decode(String.self, forKey: CodingKeys.hairColor)
        self.skinColor = try valueContainer.decode(String.self, forKey: CodingKeys.skinColor)
        self.eyeColor = try valueContainer.decode(String.self, forKey: CodingKeys.eyeColor)
        self.birthYear = try valueContainer.decode(String.self, forKey: CodingKeys.birthYear)
        self.gender = try valueContainer.decode(String.self, forKey: CodingKeys.gender)
    }
}

struct CharacterList: Codable {
    let charList: [Character]
    
    enum CodingKeys: String, CodingKey {
        case charList = "results"
    }
    
}

protocol CharacterServiceProtocol {
    var count: Int {get}
    
    func getAllCharacterName() -> [String]
    func setCharacters(newCharacters: Data)
    func getCharacterAtIndex(index: Int) -> Character
    func getCharacterNameAtIndex(index: Int) -> String
}

class CharacterKeeper: CharacterServiceProtocol {
    private var characterList: [Character]?
    
    var count: Int {
        get {
            return self.characterList?.count ?? 0
        }
    }
    
    func setCharacterList(charList: [Character]) {
        self.characterList = charList
    }
    
    func getCharacterlist() -> [Character] {
        return self.characterList ?? []
    }
    
    func getCharNameAtIndex(index: Int) -> String {
        return characterList?[index].name ?? ""
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
    
    func setCharacters(newCharacters: Data) {
        if let charList = try?
            JSONDecoder().decode(CharacterList.self, from: newCharacters) {
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

