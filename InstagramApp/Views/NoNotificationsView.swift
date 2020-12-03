//
//  NoNotificationsView.swift
//  InstagramApp
//
//  Created by Sergey on 12/1/20.
//

import UIKit

class NoNotificationsView: UIView {

    //Views that will be displayed on this view
    private let noNotificationsLabel : UILabel = {
        let label = UILabel()
        label.text = "No Notifications Yet"
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Frame of the imageview
        imageView.frame = CGRect(x: (width - 50) / 2,
                                 y: 0,
                                 width: 50,
                                 height: 50)
        //Frame of the label
        noNotificationsLabel.frame = CGRect(x: 0,
                                            y: imageView.bottom,
                                            width: width,
                                            height: height - 50)
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        addSubview(noNotificationsLabel)
        addSubview(imageView)
    }
    
}
