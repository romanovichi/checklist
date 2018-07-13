//
//  View.swift
//  Checklist
//
//  Created by Иван Романович on 24.03.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func animateBounce(forConstraint constraint: NSLayoutConstraint,
                       withHeight height: CGFloat,
                       withAlpha alpha: CGFloat) {

        constraint.constant = height
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.alpha = alpha
            self.superview?.layoutIfNeeded()

        })
        
    }
    
    func animateHide(forConstraint constraint: NSLayoutConstraint) {
        constraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.superview?.layoutIfNeeded()
        })
    }
}

extension UIView {
    
    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public func addSwipeGestureRecognizer(swipeDirection: UISwipeGestureRecognizerDirection? = nil, action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let addSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleTapGesture))
        if let direction = swipeDirection {
            addSwipeGestureRecognizer.direction = direction
        }
        self.addGestureRecognizer(addSwipeGestureRecognizer)
    }
    
    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
}
