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
    
    private var hero: Hero?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var massLabel: UILabel!
    @IBOutlet private weak var hairColorLabel: UILabel!
    @IBOutlet private weak var skinColorLabel: UILabel!
    @IBOutlet private weak var eyeColorLabel: UILabel!
    @IBOutlet private weak var birthYearLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInfoLabel()
    }
    
    private func updateInfoLabel() {
        guard let hero = self.hero else {
            return
        }
       
        nameLabel.text = hero.name
        heightLabel.text = hero.height
        massLabel.text = hero.mass
        hairColorLabel.text = hero.hairColor
        skinColorLabel.text = hero.skinColor
        eyeColorLabel.text = hero.eyeColor
        birthYearLabel.text = hero.birthYear
        genderLabel.text = hero.gender
    }
    
    func setHero(hero: Hero?) {
        self.hero = hero
    }
}
