//
//  ThemeVC.swift
//  Checklist
//
//  Created by Иван Романович on 04.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class ThemeVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    var adapter: ThemeTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = ThemeTableViewAdapter(classTable: tableView, navBar: navigationBar)
        
        addNavigationControllerBackActions()
    }
    
}

