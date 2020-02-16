//
//  SearchManager.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchData {
    func search(request: SearchRequest);
}

class SearchManager: SearchData {
    private let SEARCH_DELAY = 1.0
    
    private let networkManager: NetWorkManager
    private var delayer: SearchDelayer?
    
    init() {
        self.networkManager = NetWorkManager()
    }
    
    func search(request: SearchRequest) {
        if self.delayer != nil {
            configDelayer(delayedFunc: self.networkManager.searchCharacter(request:),
                          request: request)
        } else {
            self.delayer = SearchDelayer(delay: self.SEARCH_DELAY,
                                         delayedFunc: self.networkManager.searchCharacter(request:),
                                         request: request)
        }
        
        self.delayer?.call()
    }
    
    func configDelayer(delayedFunc: @escaping (SearchRequest) -> (), request: SearchRequest) {
        self.delayer?.config(delay: self.SEARCH_DELAY,
                             delayedFunc: delayedFunc,
                             request: request)
    }
    
    func cancelSearch() {
        self.delayer?.cancelTimerFire()
        self.networkManager.cancelCurrentTask()
    }
}
