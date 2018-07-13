//
//  ProjectTableViewAdapter.swift
//  Checklist
//
//  Created by Иван Романович on 07.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit
import RealmSwift

protocol ProjectTableViewAdapterDelegate: class {
    func segueToProject(byId id: String)
    func editProject(_ projectId: String)
}

class ProjectTableViewAdapter: NSObject {
    
    private let table: UITableView!
    private let storage = Storage.instance
    weak var delegate: ProjectTableViewAdapterDelegate?
    
    init(classTable: UITableView) {
        
        table = classTable
        
        table.registerCell(.projectCell)
        table.tableFooterView = UIView()
        
        super.init()
        
        table.delegate = self
        table.dataSource = self
    }
    
    func updateTable() {
        table.reloadData()
    }
}

extension ProjectTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.projectStorage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as? ProjectTableViewCell {
            let project = storage.projectStorage[indexPath.row]
            
            cell.updateCell(byText: project.name, AndIcon: project.icon)
            cell.selectionStyle = .none

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.segueToProject(byId: storage.projectStorage[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = tableView.deleteAction {
            self.storage.deleteProject(at: indexPath.row)
            self.updateTable()
        }
        let edit = tableView.editAction {
            self.delegate?.editProject(self.storage.projectStorage[indexPath.row].id)
        }
        return UISwipeActionsConfiguration(actions: [edit, delete])
    }
}
