//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramApp
//
//  Created by Sergey on 11/30/20.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    //Views that will be displayed on this header
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "squareImage")
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sergey Chsherbak"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio: 20 y.o. dev."
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        setInitialUI()
        setButtonTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the profilePhotoImage
        let profilePhotoSize = width / 4
        profilePhotoImageView.frame = CGRect(x: 10,
                                             y: 10,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize)
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height / 2
        //Frame of buttons
        let buttonHeight = profilePhotoSize / 2
        let buttonWidth = (width - 10 - profilePhotoSize) / 3
        //Posts button
        postsButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 10,
                                   width: buttonWidth,
                                   height: buttonHeight)
        //Followers button
        followersButton.frame = CGRect(x: postsButton.right,
                                   y: 10,
                                   width: buttonWidth,
                                   height: buttonHeight)
        //Following button
        followingButton.frame = CGRect(x: followersButton.right,
                                   y: 10,
                                   width: buttonWidth,
                                   height: buttonHeight)
        //Frame Of the editButton
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right + 20,
                                       y: 10 + buttonHeight,
                                   width: (buttonWidth * 3) - 40,
                                   height: buttonHeight)
        //Frame of the name label
        nameLabel.frame = CGRect(x: 10,
                                 y: profilePhotoImageView.bottom + 10,
                                   width: width - 20,
                                   height: 50)
        //Frame of the bio label
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 10,
                                y: nameLabel.bottom + 10,
                                   width: width - 20,
                                   height: bioLabelSize.height)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Adding views
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    ///Sets tergets to the buttons
    private func setButtonTargets() {
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
}
