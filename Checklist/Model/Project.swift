//
//  Project.swift
//  Checklist
//
//  Created by Иван Романович on 23.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Project: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var icon = ""
    @objc dynamic private var imageData: NSData? = nil
    var projectTasks = List<Task>()
    
    var coverImage: UIImage {
        set {
            imageData = UIImageJPEGRepresentation(newValue, 1) as NSData?
        }
        get {
            if let imageNSData = imageData {
                let imageData = Data(referencing: imageNSData)
                guard let image = UIImage(data: imageData) else { return UIImage() }
                return image
            }
            return UIImage()
        }
    }
    
    convenience init(named name: String, AndIcon icon: String? = nil) {
        self.init()
        self.name = name
        self.icon = icon ?? Constants.projectIcons[2]
        if let image = UIImage(named: "placeholder-image") {
            coverImage = image
        }
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
