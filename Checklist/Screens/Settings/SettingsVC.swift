//
//  SettingsVC.swift
//  Checklist
//
//  Created by Иван Романович on 26.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class SettingsVC: BaseVC {
    
    @IBOutlet weak var changeThemeButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupGestureRecognizer()
    }
}

extension SettingsVC {
    
    func setupNavigationBar() {
        
        addNavigationControllerBackActions()
        navigationBar.setTitle("Настройки")
    }
    
    func setupGestureRecognizer() {
        
        changeThemeButton.addTapGestureRecognizer {
            let theme = ThemeVC()
            self.navigationController?.pushViewController(theme, animated: true)
        }
    }
}
