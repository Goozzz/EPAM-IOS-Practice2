//
//  Router.swift
//  Practice2
//
//  Created by Евгений Гусев on 18.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

class SearchRouter: SearchRouterProtocol {
    private let detailSegueIdentifier = "showDetailCharInformation"
    
    private weak var viewController: SearchViewControllerProtocol!
    
    init(viewController: SearchViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func showDetailView(sender: Any?) {
        viewController.performSegue(segueIdentifier: detailSegueIdentifier, sender: sender)
    }    
}
