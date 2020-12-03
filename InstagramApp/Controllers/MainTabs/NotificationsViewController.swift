//
//  NotificationsViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit

///Controller that represent NotificationCenter
class NotificationsViewController: UIViewController {

    //Views that will be displayed on this controller
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationEventFollowTableViewCell.self, forCellReuseIdentifier: NotificationEventFollowTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var notificationsView = NoNotificationsView()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()
    
    //Constants and variables
    private var models = [UserNotification]()
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        setInitialUI()
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the tableView
        tableView.frame = view.bounds
        //Frame of the noNotificationsView
        //Frame of the spinner
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }

    ///Sets Initial UI
    private func setInitialUI() {
        //Set navigationBar title
        navigationItem.title = "Activity"
        //Set main view's background color
        view.backgroundColor = .systemBackground
        //Adding tableView to the main view
        view.addSubview(tableView)
        view.addSubview(notificationsView)
        view.addSubview(spinner)
//        spinner.startAnimating()
    }
    
    ///Sets Delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Sets the layout of noNotificationView
    private func layoutNoNotificationView() {
        tableView.isHidden = true
        notificationsView.frame = CGRect(x: 0, y: 0, width: view.width / 2, height: view.height / 5)
        notificationsView.center = view.center
    }
    
    ///Fetches notifications
    private func fetchNotifications() {
        let user = User(username: "iamsergeychsherbak", profilePicture: URL(string: "https://www.google.com/")!, bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCounts(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: "", likes: [], comments: [], createdDate: Date(), taggesUsers: [], owner: user)
        for i in 0...100 {
            let model = UserNotification(type: i % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello world",
                                         user: user)
            models.append(model)
            if models.count == 0 {
                tableView.isHidden = true
            } else {
                tableView.isHidden = false
            }
        }
    }
    
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource Realization

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            //Like Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.delegate = self
            cell.configure(with: model)
            return cell
        case .follow:
            //Follow Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationEventFollowTableViewCell.identifier, for: indexPath) as! NotificationEventFollowTableViewCell
            cell.delegate = self
//            cell.configure(with: model)
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        55
    }
    
}

//MARK: - NotificationLikeEventTableViewCellDelegate Realization

extension NotificationsViewController : NotificationLikeEventTableViewCellDelegate {
   
    func didTapRelatedPostButton(model: UserNotification) {
        //Open the post when the user taps it
        switch model.type {
        case .like(let post):
            let user = User(username: "", profilePicture: URL(string: "htttps:/www.google.com/")!, bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCounts(followers: 1, following: 1, posts: 1), joinDate: Date())
            let userPostModel = UserPost(identifier: "udhueh", postType: .photo, thumbnailImage: URL(string: "htttps:/www.google.com/")!, postURL: URL(string: "htttps:/www.google.com/")!, caption: "", likes: [], comments: [], createdDate: Date(), taggesUsers: [], owner: user)
            let vc = PostViewController(model: userPostModel)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            break
        }
    }
    
}

//MARK: - NotificationEventFollowTableViewCellDelegate Realization

extension NotificationsViewController : NotificationEventFollowTableViewCellDelegate {
    func didTapFollowOrUnfollowButton(model: UserNotification) {
        print("Tapped post")
        //Follow or unfollow user
    }
    
}
