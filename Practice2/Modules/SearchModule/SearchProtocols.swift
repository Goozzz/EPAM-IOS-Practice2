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
    
    func getAllCharacters(searchText: String)
    func showCharacters(charactersName: [String])
    func prepareSearchTableViewCell(index: Int) -> String
    func getCharacterCount() -> Int
    func characterCellSelected(sender: Any?)
    func prepareForShowDetailInfo(name: String, destination: DetailInfoViewController)
}

protocol SearchInteractorProtocol: class {
    func searchCharacterList(searchText: String)
    func getCharacterForCell(index: Int) -> Character
    func getNameForCell(index: Int) -> String
    func getCharacterCount() -> Int
    func getCharacterBy(name: String) -> Character
}

protocol SearchViewControllerProtocol: class {
    var presenter: SearchPresenterProtocol! {set get}
    
    func updateSearchTableView()
    func peformSegue(segueIdentifier: String, sender: Any?)
}
