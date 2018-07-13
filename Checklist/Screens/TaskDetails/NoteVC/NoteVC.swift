//
//  NoteVC.swift
//  Checklist
//
//  Created by Иван Романович on 28.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

class NoteVC: BaseVC {

    @IBOutlet weak var noteTextView: UITextView!
    var noteText: String?
    var onCompleteAdding: ((_ note: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.becomeFirstResponder()
        noteTextView.text = noteText

        setupNavigationBar()
    }
}


extension NoteVC {
    
    func setupNavigationBar() {
        
        addNavigationControllerBackActions()
        navigationBar.setTitle("Заметка")
        navigationBar.setTheme(newMainColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), backgroundColor: #colorLiteral(red: 1, green: 0.9609650565, blue: 0.7526941444, alpha: 1))
        
        navigationBar.addNavigationButton(.addButton) {
            if let noteText = self.noteTextView.text {
                self.onCompleteAdding?(noteText)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
}
