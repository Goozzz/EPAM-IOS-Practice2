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
    private let MAX_SEARCH_DELAY = 30
    
    private weak var currentTask: URLSessionDataTask?
    private weak var currentTaskTimer: Timer?
    
    private func setTask(task: URLSessionDataTask) {
        self.currentTask = task
    }
    
    private func setTimer(delay: Int) {
        
    }
    
    func cancelCurrentTask() {
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
            
            if let data = data {
                if let charList = try?
                    JSONDecoder().decode(CharacterList.self, from: data) {
                    if(charList.charList.isEmpty) {
                        return
                    }
                    request.dataHandler(charList.charList)
                }
            }
        }
        self.resumeCurrentTask()
    }
}
