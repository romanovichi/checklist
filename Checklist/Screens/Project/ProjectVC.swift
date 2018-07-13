//
//  ProjectVC.swift
//  Checklist
//
//  Created by Иван Романович on 26.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectVC: BaseVC{
    
    @IBOutlet var projectTableView: UITableView!
    
    private var adapter: ProjectTableViewAdapter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        adapter = ProjectTableViewAdapter(classTable: projectTableView)
        adapter.delegate = self
        
        setupNavigationBar()
        
    }
}

extension ProjectVC: ProjectTableViewAdapterDelegate {
    
    func segueToProject(byId id: String) {
        let checklist = ChecklistVC()
        checklist.forProject(byId: id)
        navigationController?.pushViewController(checklist, animated: true)
    }
    
    func editProject(_ projectId: String) {
        let projectDetails = ProjectDetailsVC()
        projectDetails.projectToEdit(projectId)
        self.navigationController?.pushViewController(projectDetails, animated: true)
        
        projectDetails.onCompleteEdit = {
            self.adapter.updateTable()
        }
    }
}

extension ProjectVC {
    
    private func setupNavigationBar() {
        
        navigationBar.addNavigationButton(.addButton) {
            let project = ProjectDetailsVC()
            self.navigationController?.pushViewController(project, animated: true)
            
            project.onCompleteAdd = {
                self.adapter.updateTable()
            }
        }
        
        navigationBar.addNavigationButton(.settingsButton) {
            let settings = SettingsVC()
            self.navigationController?.pushViewController(settings, animated: true)
        }
    }
}
