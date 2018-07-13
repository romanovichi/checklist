//
//  ProjectDetailsVCViewController.swift
//  Checklist
//
//  Created by Иван Романович on 08.05.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class ProjectDetailsVC: BaseVC, UIScrollViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var projectSetHeaderView: UIView!
    @IBOutlet weak var blurImage: UIVisualEffectView!
    
    @IBOutlet weak var imageViewHeighConstraint: NSLayoutConstraint!
    
    var onCompleteAdd: (()->())?
    var onCompleteEdit: (()->())?
    
    private var currentProject: Project = Project(named: "")
    private var isEditingProject: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectNameTextField.becomeFirstResponder()
        
        setupFields()
        setupNavigationBar()
        setupGestureRecognzer()
        registerForKeyboardNotifications()
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}

extension ProjectDetailsVC {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProjectDetailsVC{
    
    private func setupGestureRecognzer() {
        
        projectSetHeaderView.addTapGestureRecognizer {
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            image.allowsEditing = false
            self.present(image, animated: true)
        }
    }
}

// MARK: Edit project
extension ProjectDetailsVC {
    
    func projectToEdit(_ projectId: String) {
        if let currentProject = storage.getCurrentProject(by: projectId) {
            self.currentProject = currentProject
        }
        isEditingProject = true
    }
    
    private func setupFields() {
        if isEditingProject {
            projectNameTextField.text = currentProject.name
            imageView.image = currentProject.coverImage
        }
    }
}

// MARK: Navigation
extension ProjectDetailsVC {
    
    private func setupNavigationBar() {
        addNavigationControllerBackActions()
        navigationBar.setTheme(newMainColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), backgroundColor: #colorLiteral(red: 0.3291362627, green: 0.3291362627, blue: 0.3291362627, alpha: 0))
        navigationBar.setTitle("Проект")
        
        navigationBar.addNavigationButton(.addButton) {
            self.saveProject()
        }
    }
    
    private func unwrapFields() {
        if let taskName = projectNameTextField.text {
            currentProject.name = taskName
        }
        if let taskCoverImage = imageView.image {
            currentProject.coverImage = taskCoverImage
        }
    }
    
    private func saveProject() {
        if projectNameTextField.text != "" {
            if isEditingProject {
                storage.updateProject {
                    self.unwrapFields()
                }
                onCompleteEdit?()
                back()
            } else {
                unwrapFields()
                storage.addNew(project: currentProject)
                onCompleteAdd?()
                back()
            }
        }
    }
}

// MARK: Animation for Header image
extension ProjectDetailsVC {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let imageHeight = imageViewHeighConstraint.constant - navigationBar.frame.height
        scrollView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let y = 190 - (offsetY + 130)
        let height = min(max(y, 60), 1000)
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        blurImage.alpha = 1 + (offsetY / 190)
    }
}

// MARK: Animation when keyboard appears
extension ProjectDetailsVC {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardDidShow , object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let scrollPoint = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(scrollPoint, animated: true)
    }
}
