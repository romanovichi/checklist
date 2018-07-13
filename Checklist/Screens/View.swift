//
//  View.swift
//  Checklist
//
//  Created by Иван Романович on 24.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

enum View: String {
    
    case projectCell = "ProjectTableViewCell"
    case taskCell = "TaskTableViewCell"
    case themeCell = "ThemeCell"
    
    func instantiate() -> UINib? {
        return UINib(nibName: rawValue, bundle: nil)
    }
}

extension UITableView {
    
    func registerCell(_ view: View) {
        if let nib = view.instantiate() {
            register(nib, forCellReuseIdentifier: view.rawValue)
        } else {
            fatalError("couldn't register cell \(self)")
        }
    }
    
    func dequeueReusableCell(of view: View, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: view.rawValue, for: indexPath)
    }
    
}
