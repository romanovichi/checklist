//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Иван Романович on 17.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation

class Task: NSObject {
    
    var itemLabel = ""
    var checked = false

    func toggleChecked() {
        checked = !checked
    }
    
}
