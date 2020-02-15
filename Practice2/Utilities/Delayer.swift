//
//  Delayer.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

class SearchDelayer {
    private var delay: Double
    private weak var timer: Timer?
    private var delayedFunc: (SearchRequest) -> ()
    
    private var request: SearchRequest
    
    init(delay: Double, delayedFunc: @escaping (SearchRequest) -> (), request: SearchRequest) {
        self.delay = delay
        self.delayedFunc = delayedFunc
        self.request = request
        self.timer = nil
    }
    
    
    func call() {
        timer?.invalidate()
        timer = nil
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(SearchDelayer.fireNow), userInfo: nil, repeats: false)
        timer = nextTimer
    }
    
    @objc func fireNow() {
        self.delayedFunc(request)
    }
    
    func config(delay:Double, delayedFunc: @escaping (SearchRequest) -> (), request: SearchRequest) {
        self.timer?.invalidate()
        self.timer = nil
        self.delay = delay
        self.delayedFunc = delayedFunc
        self.request = request
    }
}
