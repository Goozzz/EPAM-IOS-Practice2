//
//  SearchProtocols.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchRouterProtocol: class {
    func showDetailView(sender: Any?)
}

protocol SearchConfiguratorProtocol: class {
    func config(viewController: SearchViewController)
}

protocol SearchPresenterProtocol: class {
    var interactor: SearchInteractorProtocol! {set get}
    var router: SearchRouterProtocol! {set get}
    
    func getAllHeroes(searchText: String)
    func showHeroes(heroesNames: [String])
    func prepareSearchTableViewCell(index: Int) -> String
    func getHeroesCount() -> Int
    func heroCellSelected(sender: Any?)
    func prepareForShowDetailInfo(name: String, destination: DetailInfoViewController)
}

protocol SearchInteractorProtocol: class {
    func searchHeroesList(searchText: String)
    func getHeroForCell(index: Int) -> Hero
    func getHeroNameForCell(index: Int) -> String
    func getHeroesCount() -> Int
    func getHeroByName(name: String) -> Hero
}

protocol SearchViewControllerProtocol: class {
    var presenter: SearchPresenterProtocol! {set get}
    
    func updateSearchTableView()
    func performSegue(segueIdentifier: String, sender: Any?)
}
