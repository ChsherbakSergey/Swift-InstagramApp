//
//  FeedPostActionsTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 11/29/20.
//

import UIKit

protocol FeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()
}

class FeedPostActionsTableViewCell: UITableViewCell {
    
    //Views that will be displayed on this cell
    private let likeButton : UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton : UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let sendButton : UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()

    //Constants and variables
    static let identifier = "FeedPostActionsTableViewCell"
    
    weak var delegate: FeedPostActionsTableViewCellDelegate?
    
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
    }
    
    ///Configures the cell
    public func configure(with post: UserPost) {
        //Configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonSize = contentView.height - 10
        
        let buttons = [likeButton, commentButton, sendButton]
        for i in 0..<buttons.count {
            let button = buttons[i]
            button.frame = CGRect(x: (CGFloat(i) * buttonSize + (10 * CGFloat(i + 1))), y: 5, width: buttonSize, height: buttonSize)
        }
        //frame of the like button

        //frame of the comment button
        
        //frame of the send button
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //adding subviews
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(sendButton)
    }
    
    ///Sets targets to buttons
    private func setTargetsToButtons() {
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }

    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
    }
    
    @objc private func didTapSendButton() {
        delegate?.didTapSendButton()
    }
    
}
