//
//  CharacterModel.swift
//  Practice2
//
//  Created by Евгений Гусев on 13.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation

struct Character: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
            case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
    }

}
