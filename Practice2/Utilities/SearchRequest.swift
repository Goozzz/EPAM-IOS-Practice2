//
//  SearchRequest.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

class SearchRequest {
    var searchText: String
    var dataHandler: ([Character]) -> ()
    
    init(searchText: String, handler: @escaping ([Character]) -> ())  {
        self.searchText = searchText
        self.dataHandler = handler
    }
}
