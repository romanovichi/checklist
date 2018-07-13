//
//  ThemeTableViewAdapter.swift
//  Checklist
//
//  Created by Иван Романович on 04.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation

import UIKit

class ThemeTableViewAdapter: NSObject {
    
    private let table: UITableView!
    private let navigationBar: CustomNavigationView!
    
    init(classTable: UITableView, navBar: CustomNavigationView) {
        
        table = classTable
        navigationBar = navBar
        
        table.registerCell(.themeCell)
        table.tableFooterView = UIView()
        
        navBar.setTitle("Темы")
        
        super.init()
        
        table.delegate = self
        table.dataSource = self
    }
}

extension ThemeTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Theme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as? ThemeCell {
            if let themeIndex = Theme(rawValue: indexPath.row) {
                cell.updateCell(byText: themeIndex.parametrs.name, AndColor: themeIndex.parametrs.backgroungColor)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newTheme = Theme(rawValue: indexPath.row) {
            ThemeManager.applyTheme(theme: newTheme)
            NotificationCenter.default.post(name: .newTheme, object: nil)
        }
    }
}
