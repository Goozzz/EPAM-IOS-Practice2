//
//  SearchTableViewCell.swift
//  Practice2
//
//  Created by Евгений Гусев on 13.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareForAppear(text: String) {
        myLabel.text = text
    }
}
