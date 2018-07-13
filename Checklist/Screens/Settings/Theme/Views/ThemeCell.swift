//
//  ThemeCell.swift
//  Checklist
//
//  Created by Иван Романович on 04.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var themeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        colorView.layer.cornerRadius = colorView.frame.size.width/2
        colorView.clipsToBounds = true
    }
    
    func updateCell(byText text: String, AndColor color: UIColor) {
        themeName.text = text
        colorView.backgroundColor = color
    }
}
