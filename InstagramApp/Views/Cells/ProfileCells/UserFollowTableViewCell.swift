//
//  UserFollowTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 11/30/20.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowOrUnfollowButton(model : UserRelationship)
}

class UserFollowTableViewCell: UITableViewCell {
    
    //Views that will be displayed on this cell
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemOrange
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
//        label.backgroundColor = .lightGray
        label.text = "Sergey Chsherbak"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
//        label.backgroundColor = .lightGray
        label.text = "iamsergeychsherbak"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let followOrUnfollowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    //Constants and Variables
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        selectionStyle = .none
        setInitialUI()
        setTargetToButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followOrUnfollowButton.setTitle(nil, for: .normal)
        followOrUnfollowButton.layer.borderWidth = 0
        followOrUnfollowButton.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the profile imageView
        profileImageView.frame = CGRect(x: 10,
                                        y: 5,
                                        width: contentView.height - 10,
                                        height: contentView.height - 10)
        profileImageView.layer.cornerRadius = profileImageView.height / 2.0
        //Frame of the labels
        let labelHeight = contentView.height / 2.0 - 5
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        //Frame of the name label
        nameLabel.frame = CGRect(x: profileImageView.right + 10,
                                 y: 5,
                                 width: contentView.width - profileImageView.right - 20 - 10 - buttonWidth,
                                 height: labelHeight)
        //Frame of the username label
        usernameLabel.frame = CGRect(x: profileImageView.right + 10,
                                     y: nameLabel.bottom,
                                 width: contentView.width - profileImageView.right - 20 - 10 - buttonWidth,
                                 height: labelHeight)
        //Frame of the followOrUnfollowButton
        followOrUnfollowButton.frame = CGRect(x: contentView.width - 10 - buttonWidth,
                                              y: 12.5,
                                              width: buttonWidth,
                                              height: 30)
        followOrUnfollowButton.layer.cornerRadius = 5
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Adding subviews
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followOrUnfollowButton)
    }
    
    ///Sets targets to buttons
    func setTargetToButtons() {
        followOrUnfollowButton.addTarget(self, action: #selector(didTapFollowOrUnfollowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowOrUnfollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowOrUnfollowButton(model: model)
    }
    
    ///Configures the cell
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.followType {
        case .following:
            //Show unfollow button
            followOrUnfollowButton.setTitle("Unfollow", for: .normal)
            followOrUnfollowButton.setTitleColor(.label, for: .normal)
            followOrUnfollowButton.backgroundColor = .systemBackground
            followOrUnfollowButton.layer.borderWidth = 1
            followOrUnfollowButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //Show follow button
            followOrUnfollowButton.setTitle("Follow", for: .normal)
            followOrUnfollowButton.setTitleColor(.white, for: .normal)
            followOrUnfollowButton.backgroundColor = .systemBlue
        }
    }
}
