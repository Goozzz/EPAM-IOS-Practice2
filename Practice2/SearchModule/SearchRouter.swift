//
//  Router.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

protocol SearchRouterProtocol: class {
    
}

class SearchRouter: SearchRouterProtocol {
    private weak var viewController: SearchViewControllerProtocol!
    
    init(viewController: SearchViewControllerProtocol) {
        self.viewController = viewController
    }
}
