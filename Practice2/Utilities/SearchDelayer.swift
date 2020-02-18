//
//  Delayer.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol SearchDelayerProtocol: class {
    func call()
    func cancelTimerFire()
    func config(delayedFunc: @escaping (String) -> (), data: String)
}

class SearchDelayer: SearchDelayerProtocol {
    private let START_SEARCH_DELAY = 0.75
    private weak var timer: Timer?
    private var delayedFunc: ((String) -> ())?
    
    private var data = ""
    
    func call() {
        self.timer?.invalidate()
        self.timer = nil
        let nextTimer = Timer.scheduledTimer(timeInterval: self.START_SEARCH_DELAY, target: self, selector: #selector(SearchDelayer.fireNow), userInfo: nil, repeats: false)
        self.timer = nextTimer
    }
    
    @objc private func fireNow() {
        self.delayedFunc?(self.data)
    }
    
    func cancelTimerFire() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func config(delayedFunc: @escaping (String) -> (), data: String) {
        self.timer?.invalidate()
        self.timer = nil
        self.data = data
        self.delayedFunc = delayedFunc
    }
}
