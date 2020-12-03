//
//  NotificationLikeEventTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 12/1/20.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    //Views that will be displayed on this cell
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemOrange
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemOrange
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let labelWithText : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "iamsergeychsherbak liked your photo"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let postButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "squareImage"), for: .normal)
        button.layer.masksToBounds = true
        return button
    }()
    
    //Constants and Variables
    static let identifier = "NotificationLikeEventTableViewCell"
    
    public weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private var model: UserNotification?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        setInitialUI()
        setTargetsToButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        labelWithText.text = nil
        postButton.setTitle(nil, for: .normal)
        postButton.setTitleColor(nil, for: .normal)
        postButton.backgroundColor = nil
        postButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the photo
        profileImageView.frame = CGRect(x: 10,
                                        y: 5,
                                        width: contentView.height - 10,
                                        height: contentView.height - 10)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        //Frame of the post button
        let size = contentView.height - 10
        postButton.frame = CGRect(x: contentView.width - size - 10,
                                  y: 5,
                                  width: size,
                                  height: size)
        postButton.layer.cornerRadius = 5
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
        contentView.addSubview(postButton)
        selectionStyle = .none
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard thumbnail.absoluteString.contains("google.com") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
            break
        }
        labelWithText.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePicture, completed: nil)
    }

}
