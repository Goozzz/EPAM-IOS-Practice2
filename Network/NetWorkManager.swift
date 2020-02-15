//
//  SearchNetWorkManager.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//



import Foundation

class NetWorkManager {
    
    private let STAR_WARS_SEARCH_URL = "https://swapi.co/api/"
    
    private var currentTask: URLSessionDataTask?
    
    private func setTask(task: URLSessionDataTask) {
        self.currentTask = task
    }
    
    func cancelCurrentTask() {
        self.currentTask?.cancel()
    }
    
    func resumeCurrentTask() {
        self.currentTask?.resume()
    }
    
    func searchCharacter(searchText: String) {
        let url = URL(string: "\(STAR_WARS_SEARCH_URL)\(searchText)")!
        
        self.cancelCurrentTask()
        
        self.currentTask = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
            let jsonDecoder = JSONDecoder()
        
            if let data = data {
                if let charList = try?
                    jsonDecoder.decode(CharacterList.self, from: data) {
                    if(charList.charList.isEmpty) {
                        return
                    }
                    
                    print(charList.charList[0].name)
                }
            }
        }
        self.resumeCurrentTask()
    }
}
