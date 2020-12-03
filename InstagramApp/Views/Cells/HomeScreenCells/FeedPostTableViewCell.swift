//
//  FeedPostTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 11/29/20.
//

import UIKit
import AVFoundation
import SDWebImage

///Cell for post content
final class FeedPostTableViewCell: UITableViewCell {
    
    //Views that will be displayed on this cell
    private let postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    //Constants and Variables
    static let identifier = "FeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the postImageView
        postImageView.frame = contentView.bounds
        //Frame of the player
        playerLayer.frame = contentView.bounds
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //Adding subviews
        addSubview(postImageView)
        //AVLayer
        contentView.layer.addSublayer(playerLayer)
    }
    
    ///Configures the cell
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "squareImage")
        
        return
        //Configure the cell
        switch post.postType {
        case .photo:
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            //Play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
}
