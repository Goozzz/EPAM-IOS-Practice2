//
//  NetworkManager.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func cancelCurrentRequest()
    func getAllCharacters(searchText:String, completion: @escaping (Data) ->())
}

class NetWorkManager: NetworkServiceProtocol {
    
    private let STAR_WARS_SEARCH_URL = "https://swapi.co/api/people/?search="
    private let MAX_SEARCH_DELAY = 30.0
    
    private weak var currentTask: URLSessionDataTask?
    private weak var currentTaskTimer: Timer?
    
    private func setTask(task: URLSessionDataTask) {
        currentTask = task
    }
    
    private func setTimer() {
        currentTaskTimer?.invalidate()
        currentTaskTimer = nil
        currentTaskTimer = Timer.scheduledTimer(timeInterval: MAX_SEARCH_DELAY,
                                                target: self,
                                                selector: #selector(cancelCurrentRequest),
                                                userInfo: nil,
                                                repeats: false)
    }
    
    @objc func cancelCurrentRequest() {
        currentTaskTimer?.invalidate()
        currentTaskTimer = nil
        currentTask?.cancel()
    }
    
    private func resumeCurrentRequest() {
        setTimer()
        currentTask?.resume()
    }
    
    func getAllCharacters(searchText:String, completion: @escaping (Data) ->()) {
        guard let url = URL(string: "\(STAR_WARS_SEARCH_URL)\(searchText)") else {
            return
        }
        
        cancelCurrentRequest()
        
        currentTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let downloadedData = data else {
                return
            }
            
            completion(downloadedData)
        }

        resumeCurrentRequest()
    }
}
