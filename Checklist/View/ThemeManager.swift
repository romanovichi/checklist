//
//  ThemeManager.swift
//  Checklist
//
//  Created by Иван Романович on 02.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit

struct  ThemeParametrs {
    let name: String
    let backgroungColor: UIColor
    let mainColor: UIColor
    let textColor: UIColor
}

enum Theme: Int {
    
    case defaultTheme, theme2, theme3, theme4, theme5
    
    static let count: Int = {
        var max: Int = 0
        while let _ = Theme(rawValue: max) { max += 1 }
        return max
    }()
    
    var parametrs: ThemeParametrs {
        switch self {
        case .defaultTheme:
            return ThemeParametrs(name: "Основная", backgroungColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), mainColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        case .theme2:
            return ThemeParametrs(name: "Зеленая", backgroungColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), mainColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        case .theme3:
            return ThemeParametrs(name: "Серая", backgroungColor: #colorLiteral(red: 0.6397142163, green: 0.2139406855, blue: 0.1981061793, alpha: 1), mainColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        case .theme4:
            return ThemeParametrs(name: "Желтая", backgroungColor: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), mainColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        case .theme5:
            return ThemeParametrs(name: "Голубая", backgroungColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), mainColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        }
    }
}


class ThemeManager {
    
    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: Constants.SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .defaultTheme
        }
    }
    
    static func applyTheme(theme: Theme) {
        
        UserDefaults.standard.setValue(theme.rawValue, forKey: Constants.SelectedThemeKey)
        UserDefaults.standard.synchronize()
        
    }
}

