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
    private let startSearchDelay = 0.75
    private weak var timer: Timer?
    private var delayedFunc: ((String) -> ())?
    
    private var data = ""
    
    func call() {
        timer?.invalidate()
        timer = nil
        let nextTimer = Timer.scheduledTimer(timeInterval: self.startSearchDelay,
                                             target: self,
                                             selector: #selector(SearchDelayer.fireNow),
                                             userInfo: nil,
                                             repeats: false)
        timer = nextTimer
    }
    
    @objc private func fireNow() {
        delayedFunc?(self.data)
    }
    
    func cancelTimerFire() {
        timer?.invalidate()
        timer = nil
    }
    
    func config(delayedFunc: @escaping (String) -> (), data: String) {
        timer?.invalidate()
        timer = nil
        self.data = data
        self.delayedFunc = delayedFunc
    }
}
