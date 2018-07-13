//
//  ProjectTableViewCell.swift
//  Checklist
//
//  Created by Иван Романович on 27.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit

 class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectIcon: UIImageView!
    @IBOutlet weak var projectLabel: UILabel!
    
    func updateCell(byText text: String, AndIcon icon: String) {
        projectLabel.text = text
        projectIcon.image = UIImage(named: icon)
    }
}
