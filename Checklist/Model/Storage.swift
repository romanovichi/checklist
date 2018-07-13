//
//  Storage.swift
//  Checklist
//
//  Created by Иван Романович on 24.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import RealmSwift

class Storage {
    
    static let instance = Storage()
    
    let realm = try! Realm()
    var projectStorage: Results<Project>
    
    init() {
        projectStorage = realm.objects(Project.self)
    }
}

// MARK: Project CRUD
extension Storage {
    
    func addNew(project: Project) {
        try? realm.write {
            realm.add(project)
        }
    }
    
    func deleteProject(at index: Int) {
        try? realm.write {
            realm.delete(projectStorage[index])
        }
    }
    
    func getCurrentProject(by projectId: String) -> Project? {
        if let currentProject = (projectStorage.filter { $0.id == projectId }).first {
            return currentProject
        }
        return nil
    }
    
    func updateProject(completionHandler: @escaping () -> ()) {
        try? realm.write {
            completionHandler()
        }
    }
}

// MARK: Task CRUD
extension Storage {
    
    func addTask(_ task: Task, by projectId: String) {
        if let currentProject = (projectStorage.filter { $0.id == projectId }).first {
            try? realm.write {
                currentProject.projectTasks.append(task)
            }
        }
    }
    
    func removeTask(atIndex index: Int, by projectId: String) {
        if let currentProject = (projectStorage.filter { $0.id == projectId }).first {
            try? realm.write {
                currentProject.projectTasks.remove(at: index)
            }
        }
    }
    
    func getCurrentTask(by taskId: String, for projectId: String) -> Task? {
        if let currentProject = getCurrentProject(by: projectId) {
            if let currentTask = (currentProject.projectTasks.filter { $0.id == taskId }).first {
                return currentTask
            }
        }
        return nil
    }
    
    func updateTask(completionHandler: @escaping () -> ()) {
        try? realm.write {
            completionHandler()
        }
    }
    
}
