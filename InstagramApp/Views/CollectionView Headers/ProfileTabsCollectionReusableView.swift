//
//  ProfileTabsCollectionReusableView.swift
//  InstagramApp
//
//  Created by Sergey on 11/30/20.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    //Views that will be displayed on this screen
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "rectangle.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "person.crop.square"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        setInitialUI()
        setTargetsToButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of buttons
        let size = height - 10
        let gridButtonX = (width / 2 - size) / 2
        //Grid button
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: 5,
                                  width: size,
                                  height: size)
        //Tagged Button
        taggedButton.frame = CGRect(x: gridButtonX + (width / 2),
                                  y: 5,
                                  width: size,
                                  height: size)
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //Adding views
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButton), for: .touchUpInside)
    }
    
    @objc private func didTapGridButton() {
        gridButton.tintColor = .label
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    
    @objc private func didTapTaggedButton() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .label
        delegate?.didTapTaggedButtonTab()
    }
        
}
