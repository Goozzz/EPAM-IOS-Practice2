//
//  SearchPresenter.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

protocol SearchPresenterProtocol: class {
    var interactor: SearchInteractorProtocol! {set get}
    var router: SearchRouterProtocol! {set get}
}

class SearchPresenter: SearchPresenterProtocol {
    
    private weak var _viewController: ViewControllerProtocol!
    private var _interactor: SearchInteractorProtocol!
    private var _router: SearchRouterProtocol!
    
    init(viewController: ViewControllerProtocol) {
        self._viewController = viewController
    }
    
    var interactor: SearchInteractorProtocol! {
        get {
            return self._interactor
        }
        set {
            self._interactor = newValue
        }
    }
    
    var router: SearchRouterProtocol! {
        get {
            return self._router
        }
        set {
            self._router = newValue
        }
    }
    
    
    
    
}
