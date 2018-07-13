//
//  TaskTableViewCell.swift
//  Checklist
//
//  Created by Иван Романович on 12.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    func updateCell(withText text: String) {
        label.text = text
    }
}
