//
//  CustomNavigationView.swift
//  Checklist
//
//  Created by Иван Романович on 07.04.2018.
//  Copyright © 2018 Иван Романович. All rights reserved.
//

import UIKit

enum navigationButton {
    case backButton
    case addButton
    case settingsButton
}

class CustomNavigationView: UINavigationBar {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet weak var rightStackView: UIStackView!
    @IBOutlet weak var navBarLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomNavigationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true
        
        setTheme()
    }
}

extension CustomNavigationView {
    
    func setTitle(_ title: String) {
        navBarLabel.text = title
    }
    
    func setTheme(newMainColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        
        contentView.backgroundColor = backgroundColor ?? ThemeManager.currentTheme().parametrs.backgroungColor
        navBarLabel.textColor = newMainColor ?? ThemeManager.currentTheme().parametrs.textColor
        
        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = newMainColor ?? ThemeManager.currentTheme().parametrs.mainColor
        
        UITextField.appearance().tintColor = UIColor.black
    }
}


extension CustomNavigationView {
    
    func addNavigationButton(_ button: navigationButton, withAction action: @escaping () -> ()) {
        
        switch button {
            
        case .addButton:
            let addButton = setUpButton(withImage: #imageLiteral(resourceName: "addButton"))
            addButton.addAction(for: .touchUpInside, action: {
                action()
            })
            rightStackView.addArrangedSubview(addButton)
            
        case .backButton:
            let backButton = setUpButton(withImage: #imageLiteral(resourceName: "backButton"))
            backButton.addAction(for: .touchUpInside, action: {
                action()
            })
            leftStackView.addArrangedSubview(backButton)
            
        case .settingsButton:
            let settingButton = setUpButton(withImage: #imageLiteral(resourceName: "settings"))
            settingButton.addAction(for: .touchUpInside, action: {
                action()
            })
            leftStackView.addArrangedSubview(settingButton)
        }
    }
    
    private func setUpButton(withImage image: UIImage) -> UIButton {
        let button = UIButton(type: .custom)
        let aspectRatioConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal,
                                                       toItem: button, attribute: .width, multiplier: (1.0 / 1.0), constant: 0)
        let origImage = image
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        
        button.contentMode = .scaleAspectFit
        button.setImage(tintedImage, for: .normal)
        button.addConstraint(aspectRatioConstraint)
        
        return button
    }
    
}
