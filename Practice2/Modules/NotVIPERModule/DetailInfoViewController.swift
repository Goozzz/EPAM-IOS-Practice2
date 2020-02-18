//
//  DetailInfoController.swift
//  Practice2
//
//  Created by Евгений Гусев on 15.02.2020.
//  Copyright © 2020 Евгений Гусев. All rights reserved.
//

import Foundation
import UIKit

class DetailInfoViewController: UIViewController {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var massLabel: UILabel!
    @IBOutlet private weak var hairColorLabel: UILabel!
    @IBOutlet private weak var skinColorLabel: UILabel!
    @IBOutlet private weak var eyeColorLabel: UILabel!
    @IBOutlet private weak var birthYearLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    
    private var charWithInfo: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfoLabel()
    }
    
    private func updateInfoLabel() {
        nameLabel.text = self.charWithInfo?.name
        heightLabel.text = self.charWithInfo?.height
        massLabel.text = self.charWithInfo?.mass
        hairColorLabel.text = self.charWithInfo?.hairColor
        skinColorLabel.text = self.charWithInfo?.skinColor
        eyeColorLabel.text = self.charWithInfo?.eyeColor
        birthYearLabel.text = self.charWithInfo?.birthYear
        genderLabel.text = self.charWithInfo?.gender
    }
    
    func setChar(char: Hero) {
        self.charWithInfo = char
    }
}
