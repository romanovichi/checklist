//
//  ViewController.swift
//  Checklist
//
//  Created by Иван Романович on 16.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class ChecklistVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewBlurEffect: UIVisualEffectView!
    
    private var adapter: ChecklistTableViewAdapter!
    private var projectId: String = ""
    private var currentProject: Project = Project(named: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentProject = storage.getCurrentProject(by: projectId) {
            self.currentProject = currentProject
        }
        imageView.image = currentProject.coverImage
        
        adapter = ChecklistTableViewAdapter(tableView: tableView, projectId: projectId, imageView: imageView, imageViewBlurEffect: imageViewBlurEffect)
        adapter.delegate = self
        
        setupNavigationBar()
    }
}

extension ChecklistVC {
    func forProject(byId projectId: String) {
        self.projectId = projectId
    }
}

// MARK: Delegate functions
extension ChecklistVC: ChecklistTableViewAdapterDelegate {
    
    func editTask(_ taskId: String, for projectId: String) {
        let edit = AddTaskVC()
        edit.editTask(by: taskId, for: projectId)
        self.navigationController?.pushViewController(edit, animated: true)
        
        edit.onCompleteEdit = {
            self.adapter.updateTable()
        }
    }
}

// MARK: Navigation Bar
extension ChecklistVC{
    
    private func setupNavigationBar() {
        
        addNavigationControllerBackActions()
        navigationBar.setTitle(currentProject.name)
        navigationBar.setTheme(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0))
        
        navigationBar.addNavigationButton(.addButton) {
            let addTask = AddTaskVC()
            addTask.setCurrentProjectId(self.currentProject.id)
            self.navigationController?.pushViewController(addTask, animated: true)
            
            addTask.onCompleteAdd = {
                self.adapter.updateTable()
            }
        }
    }
}
