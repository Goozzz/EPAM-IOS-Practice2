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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.getHeaderForSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return presenter.getRequestsCount()
        } else {
            return presenter.getHeroesCount()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                        "SearchTableViewCell", for: indexPath)
                        as? SearchTableViewCell else {
                            return UITableViewCell() }
        
        var textForCell = ""
        if searchBarIsEmpty() {
            textForCell = presenter.getRequestForCell(index: indexPath.row)
        } else {
            textForCell = presenter.getHeroNameForCell(index: indexPath.row)
        }

        cell.prepareForAppear(text: textForCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if !searchBarIsEmpty() {
            presenter.heroCellSelected(sender: resultSearchTableView.cellForRow(at: indexPath))
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if !searchBarIsEmpty() {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteRequest(index: indexPath.row)
        }
    }
    
    private func searchBarIsEmpty() -> Bool {
        if starWarsSearchBar.text == "" {
            return true
        } else {
            return false
        }
    }
}
