//
//  ChecklistTableViewAdapter.swift
//  Checklist
//
//  Created by Иван Романович on 12.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit
import UserNotifications

protocol ChecklistTableViewAdapterDelegate: class {
    func editTask(_ taskId: String, for projectId: String)
}

class ChecklistTableViewAdapter: NSObject {
    
    private let table: UITableView!
    private let headerImageView: UIImageView!
    private let headerImageViewBlurEffect: UIVisualEffectView!
    private let storage = Storage.instance
    
    private let navigationBarHeight: CGFloat = 60
    private let initialHeaderImageViewHeight: CGFloat = 250
    
    weak var delegate: ChecklistTableViewAdapterDelegate?
    var currentProject: Project!
    
    init(tableView: UITableView, projectId: String, imageView: UIImageView, imageViewBlurEffect: UIVisualEffectView) {
        
        table = tableView
        headerImageView = imageView
        headerImageViewBlurEffect = imageViewBlurEffect
        
        if let currentProject = storage.getCurrentProject(by: projectId) {
            self.currentProject = currentProject
        }
        
        table.registerCell(.taskCell)
        table.tableFooterView = UIView()
        
        table.contentInset = UIEdgeInsets(top: 230, left: 0, bottom: 0, right: 0)
        super.init()
        
        table.delegate = self
        table.dataSource = self
    }
}


extension ChecklistTableViewAdapter {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = headerImageView.frame.height - (scrollView.contentOffset.y + headerImageView.frame.height)
        let height = min(max(y, navigationBarHeight), 500)
        
        headerImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        headerImageViewBlurEffect.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        headerImageViewBlurEffect.alpha = 1 + (scrollView.contentOffset.y + navigationBarHeight) / (initialHeaderImageViewHeight - navigationBarHeight)
    }
    
    func updateTable() {
        table.reloadData()
    }
}

extension ChecklistTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return currentProject.projectTasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell {
            let task = currentProject.projectTasks[indexPath.row]
            cell.updateCell(withText: task.name)
            
            cell.selectionStyle = .none
            
            tableView.tableFooterView = UIView()
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.editTask(self.currentProject.projectTasks[indexPath.row].id, for: currentProject.id)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = tableView.doneAction {
//            self.currentProject.projectTasks[indexPath.row].toggleChecked()
            self.storage.removeTask(atIndex: indexPath.row, by: self.currentProject.id)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            self.updateTable()
        }
        let configuration = UISwipeActionsConfiguration(actions: [done])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = tableView.deleteAction {
            if self.currentProject.projectTasks[indexPath.row].date != nil {
                NotificationHandler.removeNotification(withId: self.currentProject.projectTasks[indexPath.row].id)
            }
            self.storage.removeTask(atIndex: indexPath.row, by: self.currentProject.id)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            self.updateTable()
        }
        let edit = tableView.editAction {
            self.delegate?.editTask(self.currentProject.projectTasks[indexPath.row].id, for: self.currentProject.id)
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
