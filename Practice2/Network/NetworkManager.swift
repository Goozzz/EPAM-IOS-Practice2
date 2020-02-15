//
//  NetworkManager.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

class NetWorkManager {
    
    private let STAR_WARS_SEARCH_URL = "https://swapi.co/api/people/?search="
    private let MAX_SEARCH_DELAY = 30.0
    
    private weak var currentTask: URLSessionDataTask?
    private weak var currentTaskTimer: Timer?
    
    private func setTask(task: URLSessionDataTask) {
        self.currentTask = task
    }
    
    private func setTimer() {
        self.currentTaskTimer?.invalidate()
        self.currentTaskTimer = nil
        self.currentTaskTimer = Timer.scheduledTimer(timeInterval: self.MAX_SEARCH_DELAY, target: self, selector: #selector(self.cancelCurrentTask), userInfo: nil, repeats: false)
    }
    
    @objc func cancelCurrentTask() {
        self.currentTaskTimer?.invalidate()
        self.currentTaskTimer = nil
        print("canceled")
        self.currentTask?.cancel()
    }
    
    func resumeCurrentTask() {
        self.currentTask?.resume()
    }
    
    func searchCharacter(request: SearchRequest) {
        let url = URL(string: "\(STAR_WARS_SEARCH_URL)\(request.searchText)")!
        
        self.cancelCurrentTask()
        
        self.currentTask = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
            if error != nil {
                return
            }
            
            if let data = data, let charList = try?
                    JSONDecoder().decode(CharacterList.self, from: data) {
                    if(charList.charList.isEmpty) {
                        return
                    }
                    request.dataUpdater.updateSearchTableView(charList: charList.charList)
                }
        }
        self.setTimer()
        self.resumeCurrentTask()
    }
}
