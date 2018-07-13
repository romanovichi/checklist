//
//  BaseVC.swift
//  Checklist
//
//  Created by Иван Романович on 18.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    @IBOutlet weak var navigationBar: CustomNavigationView!
    let storage = Storage.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .newTheme, object: nil, queue: nil, using: { notification in
            self.navigationBar.setTheme()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseVC {
    
    func addNavigationControllerBackActions() {
        navigationBar.addNavigationButton(.backButton) {
            self.back()
        }
        
        self.view.addSwipeGestureRecognizer {
            self.back()
        }
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }
}
