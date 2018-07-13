//
//  DateVC.swift
//  Checklist
//
//  Created by Иван Романович on 28.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class DateVC: BaseVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    var onCompleteAdd: ((_ date: Date)->())?
    
    @IBAction func saveDate(_ sender: Any) {
        onCompleteAdd?(datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
