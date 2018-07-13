//
//  ChecklistTask.swift
//  Checklist
//
//  Created by Иван Романович on 17.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Task: Object{
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic private var _date: NSDate? = nil
    @objc dynamic var checked = false
    @objc dynamic var note: String? = "Комментарий..."
    
    var date: Date? {
        set {
            _date = newValue as NSDate?
        }
        get {
            if let date = _date {
                return date as Date
            }
            return Date()
        }
    }
    
    convenience init(named text: String) {
        self.init()
        name = text
    }
}

extension Task {
    
    func toggleChecked() {
        checked = !checked
    }
}
