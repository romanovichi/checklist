//
//  TableView.swift
//  Checklist
//
//  Created by Иван Романович on 10.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func doneAction(completionHandler: @escaping () -> ()) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            completionHandler()
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "doneIcon")
        action.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        return action
    }
    
    func editAction(completionHandler: @escaping () -> ()) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Изменить") { (action, view, completion) in
            completionHandler()
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "edit")
        action.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        return action
    }
    
    func deleteAction(completionHandler: @escaping () -> ()) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completion) in
            completionHandler()
            completion(true)
        }
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = ThemeManager.currentTheme().parametrs.backgroungColor
        
        return action
    }
    
    
}
