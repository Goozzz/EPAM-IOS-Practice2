//
//  SearchConfigurator.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

class SearchConfigurator: SearchConfiguratorProtocol {
    
    func config(viewController: SearchViewController) {
        let presenter = SearchPresenter(viewController: viewController)
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
