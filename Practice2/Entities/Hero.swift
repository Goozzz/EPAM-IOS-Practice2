//
//  Character.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

struct Hero: Codable {
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
}

struct HeroList: Codable {
    let list: [Hero]
    
    enum CodingKeys: String, CodingKey {
        case list = "results"
    }
}
