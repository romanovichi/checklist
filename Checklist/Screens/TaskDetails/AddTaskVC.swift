//
//  AddChecklistVC.swift
//  Checklist
//
//  Created by Иван Романович on 20.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class AddTaskVC: BaseVC  {

    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var taskNoteLabel: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var noteView: UIView!
    
    @IBOutlet weak var cancelTextButton: UIButton!
    @IBOutlet weak var cancelTextButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var cancelTextButtonCenterX: NSLayoutConstraint!
    
    private var currentTask: Task = Task(named: "")
    private var currentProjectId: String?
    private var isEditingTask: Bool = false
    private var reminderDate: Date?
    
    var onCompleteAdd: (()->())?
    var onCompleteEdit: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskNameField.becomeFirstResponder()
        cancelTextButtonCenterX.constant += nameView.frame.width / 2 - (cancelTextButton.frame.width) - 20

        setupFields()
        setupNavigationBar()
        setupFieldsGestureRecognizer()
    }
}

extension AddTaskVC {
    
    func setCurrentProjectId(_ projectId: String) {
        currentProjectId = projectId
    }
    
    func editTask(by taskId: String, for projectId: String) {
        currentProjectId = projectId
        if let currentTask = storage.getCurrentTask(by: taskId, for: projectId) {
            self.currentTask = currentTask
        }
        isEditingTask = true
    }
    
    private func setupFields() {
        if isEditingTask {
            taskNameField.text = currentTask.name
            if currentTask.note != nil {
                taskNoteLabel.text = currentTask.note
            }
            if let date = currentTask.date {
                taskDateLabel.text = Formatter.dateToString(fromDate: date)
            }
        }
    }
}

extension AddTaskVC {
   
    @IBAction func taskNameFieldValueChanged(_ sender: Any) {
        if taskNameField.text == "" {
            cancelTextButton.animateHide(forConstraint: cancelTextButtonHeight)
        } else {
            if !isEditingTask {
                currentTask = Task(named: "")
            }
            cancelTextButton.animateBounce(forConstraint: cancelTextButtonHeight, withHeight: 20, withAlpha: 1)
        }
    }
    
    @IBAction func cancelTextButtonAction(_ sender: Any) {
        taskNameField.text = ""
    }
}

// MARK: Set additional fields
extension AddTaskVC {
    
    private func setupFieldsGestureRecognizer() {
        
        dateView.addTapGestureRecognizer {
            
            let dateVC = DateVC()
            dateVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(dateVC, animated: true)
            
            dateVC.onCompleteAdd = { [unowned self] date in
                self.reminderDate = date
                self.taskDateLabel.text = Formatter.dateToString(fromDate: date)
            }
        }
        
        noteView.addTapGestureRecognizer {
            
            let noteVC = NoteVC()
            if self.taskNoteLabel.text != "Комментарий..." {
                noteVC.noteText = self.taskNoteLabel.text
            }
            self.navigationController?.pushViewController(noteVC, animated: true)
            
            noteVC.onCompleteAdding = { [unowned self] note in
                self.taskNoteLabel.text = note
            }
        }
    }
}

// MARK: Saving Task
extension AddTaskVC {
    
    private func setupNavigationBar() {
        
        addNavigationControllerBackActions()
        navigationBar.setTitle("Добавить задачу")
        
        navigationBar.addNavigationButton(.addButton) {
            self.saveTask()
        }
    }
    
    private func unwrapFields() {
        if let taskName = taskNameField.text {
            currentTask.name = taskName
        }
        if let date = reminderDate {
            currentTask.date = date
        }
        if let note = taskNoteLabel.text {
            currentTask.note = note
        }
    }
    
    private func saveTask() {
        if taskNameField.text != "" {
            if isEditingTask {
                storage.updateTask {
                    self.unwrapFields()
                }
                onCompleteEdit?()
                back()
            } else {
                unwrapFields()
                if let date = currentTask.date {
                    NotificationHandler.setNotification(withID: currentTask.id, Label: currentTask.name, AndDate: date, completion: { (success) in
                        if success {
                            print("OK")
                        }
                    })
                }
                if let projectId = currentProjectId {
                    storage.addTask(currentTask, by: projectId)
                }
                onCompleteAdd?()
                back()
            }
        }
    }
}
