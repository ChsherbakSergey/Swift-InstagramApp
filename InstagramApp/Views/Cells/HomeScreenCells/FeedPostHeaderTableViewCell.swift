//
//  FeedPostHeaderTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 11/29/20.
//
import SDWebImage
import UIKit

protocol FeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class FeedPostHeaderTableViewCell: UITableViewCell {
    
    //Views that will be displayed on this cell
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let moreButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .label
        button.isUserInteractionEnabled = true
        return button
    }()
    
    //Constants and variables
    static let identifier = "FeedPostHeaderTableViewCell"
    
    weak var delegate: FeedPostHeaderTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialUI()
        setTargetsToButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userNameLabel.text = nil
        profileImageView.image = nil
    }
    
    ///Configures the cell
    public func configure(with model: User) {
        //Configure the cell
        userNameLabel.text = model.username
        profileImageView.image = UIImage(named: "instagram-gradient")
//        profileImageView.sd_setImage(with: model.profilePicture, completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the profileImageView
        let size = contentView.height - 10
        profileImageView.frame = CGRect(x: 5, y: 5, width: size, height: size)
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        //Frame of the more button
        moreButton.frame = CGRect(x: contentView.width - size, y: 5, width: size, height: size)
        //frame of the usernameLabel
        userNameLabel.frame = CGRect(x: profileImageView.right + 10, y: 5, width: contentView.width - (size * 2) - 20, height: contentView.height - 10)
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //adding subviews
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(moreButton)
        //Selection style of the cell
        selectionStyle = .none
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
}
