//
//  ViewControllerTableExtention.swift
//  Practice2
//
//  Created by Евгений Гусев on 16.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getHeroesCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Search"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                        "SearchTableViewCell", for: indexPath)
                        as? SearchTableViewCell else { return UITableViewCell() }
        
        let name = presenter.prepareSearchTableViewCell(index: indexPath.row)
        cell.prepareForAppear(text: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.heroCellSelected(sender: resultSearchTableView.cellForRow(at: indexPath))
    }
}
