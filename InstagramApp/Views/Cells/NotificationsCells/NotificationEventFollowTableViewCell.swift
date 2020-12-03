//
//  NotificationEventFollowTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 12/1/20.
//

import UIKit

protocol NotificationEventFollowTableViewCellDelegate: AnyObject {
    func didTapFollowOrUnfollowButton(model: UserNotification)
}

class NotificationEventFollowTableViewCell: UITableViewCell {
    
    //Views that will be displayed on this cell
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemTeal
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let labelWithText : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "21savage started following you"
        return label
    }()
    
    private let followOrUnfollowButton : UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        return button
    }()
    
    //Constants and Variables
    static let identifier = "NotificationEventFollowTableViewCell"
    
    public weak var delegate: NotificationEventFollowTableViewCellDelegate?
    
    private var model: UserNotification?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialUI()
        setTargetsToButtons()
        contentView.clipsToBounds = true
        configureForFollow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        labelWithText.text = nil
        followOrUnfollowButton.setTitle(nil, for: .normal)
        followOrUnfollowButton.setTitleColor(nil, for: .normal)
        followOrUnfollowButton.backgroundColor = nil
        followOrUnfollowButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the photo
        profileImageView.frame = CGRect(x: 10,
                                        y: 5,
                                        width: contentView.height - 10,
                                        height: contentView.height - 10)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        //Frame of the followOrUnfollowButton button
        let size: CGFloat = 100
        followOrUnfollowButton.frame = CGRect(x: contentView.width - size - 10,
                                              y: (contentView.height - 40) / 2,
                                  width: size,
                                  height: 40)
        followOrUnfollowButton.layer.cornerRadius = 5
        //Frame of the labelWithText
        labelWithText.frame = CGRect(x: profileImageView.right + 10,
                                     y: 0,
                                     width: contentView.width - size - profileImageView.width - 20 - 10 - 10,
                                     height: contentView.height)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(labelWithText)
        contentView.addSubview(followOrUnfollowButton)
        selectionStyle = .none
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        followOrUnfollowButton.addTarget(self, action: #selector(didTapFollowOrUnfollowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowOrUnfollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowOrUnfollowButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state {
            case .following:
                //show unfollow button
                configureForFollow()
            case .not_following:
                //show follow button
                configureForUnfollow()
            }
        }
        labelWithText.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }
    
    private func configureForFollow() {
        followOrUnfollowButton.setTitle("Unfollow", for: .normal)
        followOrUnfollowButton.setTitleColor(.label, for: .normal)
        followOrUnfollowButton.backgroundColor = .systemBackground
        followOrUnfollowButton.layer.borderWidth = 1
        followOrUnfollowButton.layer.borderColor = UIColor.label.cgColor
    }
    
    private func configureForUnfollow() {
        followOrUnfollowButton.setTitle("Follow", for: .normal)
        followOrUnfollowButton.setTitleColor(.white, for: .normal)
        followOrUnfollowButton.backgroundColor = .systemBlue
    }

}
