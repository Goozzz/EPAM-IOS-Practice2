//
//  SearchManager.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchDataProtocol {
    func searchCharacterList(request: SearchRequest)
    func cancelSearch()
}

class SearchManager: SearchDataProtocol {
    private let SEARCH_DELAY = 1.0
    
    private let networkManager: NetWorkManager
    private var delayer: SearchDelayerProtocol
    
    init(request: SearchRequest) {
        self.networkManager = NetWorkManager()
        self.delayer = SearchDelayer(delay: self.SEARCH_DELAY, delayedFunc: networkManager.downloadCharacterListFromAPI(request:), request: request)
    }
    
    func searchCharacterList(request: SearchRequest) {
        configDelayer(delayedFunc: self.networkManager.downloadCharacterListFromAPI(request:),
                          request: request)
        
        self.delayer.call()
    }
    
    func configDelayer(delayedFunc: @escaping (SearchRequest) -> (), request: SearchRequest) {
        self.delayer.config(delay: self.SEARCH_DELAY,
                             delayedFunc: delayedFunc,
                             request: request)
    }
    
    func cancelSearch() {
        self.delayer.cancelTimerFire()
        self.networkManager.cancelCurrentRequest()
    }
}
