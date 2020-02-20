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
    private let DETAIL_SEGUE_IDENTIFIER = "showDetailCharInformation"
    
    private weak var viewController: SearchViewControllerProtocol!
    
    init(viewController: SearchViewControllerProtocol) {
        self.viewController = viewController
    }
    
    func showDetailView(sender: Any?) {
        self.viewController.peformSegue(segueIdentifier: self.DETAIL_SEGUE_IDENTIFIER,
                                        sender: sender)
    }    
}
