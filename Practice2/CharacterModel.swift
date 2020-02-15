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

class CharacterKeeper {
    private var characterList: [Character]?
    
    func setCharacterList(charList: [Character]) {
        self.characterList = charList
    }
    
    func getCharacterlist() -> [Character] {
        return self.characterList ?? []
    }
    
    func getCharNameAtIndex(index: Int) -> String {
        return characterList?[index].name ?? ""
    }
}

