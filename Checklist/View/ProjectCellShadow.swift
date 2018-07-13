//
//  ProjectCellShadow.swift
//  Checklist
//
//  Created by Иван Романович on 05.06.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

@IBDesignable class ProjectCellShadow: UIView {

    @IBInspectable var cornerRadius: CGFloat = 5
    @IBInspectable var shadowColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowOpacity: Float = 0.4
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOpacity = shadowOpacity
    }
}
