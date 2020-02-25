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
    func getPreviousRequestsCount() -> Int
    func getPreviousRequestsAtIndex(index: Int) -> String
    func deleteRequest(index: Int)
}

class NetWorkManager: NetworkServiceProtocol {
    
    private let starWarsSearchUrl = "https://swapi.co/api/people/?search="
    private let maxSearchDelay = 30.0
    
    private var previousRequests = UserDefaults.standard.stringArray(forKey: "previousRequests") ?? []
    
    private weak var currentTask: URLSessionDataTask?
    private weak var currentTaskTimer: Timer?
    
    private func setTask(task: URLSessionDataTask) {
        currentTask = task
    }
    
    private func setTimer() {
        currentTaskTimer?.invalidate()
        currentTaskTimer = nil
        currentTaskTimer = Timer.scheduledTimer(timeInterval: maxSearchDelay,
                                                target: self,
                                                selector: #selector(cancelCurrentRequest),
                                                userInfo: nil,
                                                repeats: false)
    }
    
    private func appendNewRequest(request: String) {
        if (!previousRequests.contains(request)) {
            previousRequests.append(request)
            UserDefaults.standard.set(previousRequests, forKey: "previousRequests")
        }
    }
    
    func getPreviousRequestsCount() -> Int {
        return previousRequests.count
    }
    
    func getPreviousRequestsAtIndex(index: Int) -> String {
        return previousRequests[index]
    }
    
    func deleteRequest(index: Int) {
        previousRequests.remove(at: index)
        UserDefaults.standard.set(previousRequests, forKey: "previousRequests")
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
        guard let url = URL(string: "\(starWarsSearchUrl)\(searchText)") else {
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
        
        appendNewRequest(request: searchText)
        resumeCurrentRequest()
    }
}
