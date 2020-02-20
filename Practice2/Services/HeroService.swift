//
//  CharacterModel.swift
//  Practice2
//
//  Created by Евгений Гусев on 13.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol HeroServiceProtocol {
    var count: Int {get}
    
    func getAllHeroName() -> [String]
    func setHeroes(newHeroes: Data?)
    func getHeroAtIndex(index: Int) -> Hero
    func getHeroNameAtIndex(index: Int) -> String
    func getHeroByName(name: String) -> Hero
}

class HeroKeeper: HeroServiceProtocol {
    private var heroList: [Hero]?
    
    var count: Int {
        get {
            return heroList?.count ?? 0
        }
    }
    
    func getHeroByName(name: String) -> Hero {
        guard let list = heroList else {
            return Hero()
        }
        for hero in list {
            if hero.name == name {
                return hero
            }
        }
        
        return Hero()
    }
    
    func getAllHeroName() -> [String] {
        guard let list = heroList else {
            return []
        }
        var heroesName: [String] = []
        
        for hero in list {
            heroesName.append(hero.name)
        }
        
        return heroesName
    }
    
    func setHeroes(newHeroes: Data?) {
        guard let data = newHeroes else {
            heroList = []
            return
        }
        
        if let heroList = try?
            JSONDecoder().decode(HeroList.self, from: data) {
            if(heroList.list.isEmpty) {
                self.heroList = []
            } else {
                self.heroList = heroList.list
            }
        }
    }
    
    func getHeroAtIndex(index: Int) -> Hero {
        return heroList?[index] ?? Hero()
    }
    
    func getHeroNameAtIndex(index: Int) -> String {
        return heroList?[index].name ?? ""
    }
}

