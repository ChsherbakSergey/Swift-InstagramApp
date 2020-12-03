//
//  ViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //Constants and variables
    private var feedRenderModels = [HomeFeedRenderViewModel]()

    //Views that will be displayed on this controller
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FeedPostTableViewCell.self, forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedPostHeaderTableViewCell.self, forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        tableView.register(FeedPostActionsTableViewCell.self, forCellReuseIdentifier: FeedPostActionsTableViewCell.identifier)
        tableView.register(FeedPostGeneralTableViewCell.self, forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        createMockModels()
    }
    
    ///Creates mock models for debugging purposes
    private func createMockModels() {
        let user = User(username: "iamsergeychsherbak", profilePicture: URL(string: "https://www.google.com/")!, bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCounts(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: "", likes: [], comments: [], createdDate: Date(), taggesUsers: [], owner: user)
        for i in 0...5 {
            var comments = [PostComment]()
            for i in 0..<2 {
                let comment = PostComment(identifier: "123_\(i)", username: "iamsergeychsherbak", text: "Nice!", createdDate: Date(), likes: [])
                comments.append(comment)
            }
            
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        handleNotAuthenticatedUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the tableView
        tableView.frame = view.bounds
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Adding subviews
        view.addSubview(tableView)
    }
    
    ///Sets delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func handleNotAuthenticatedUser() {
        //Check if the user signed in or not and if not present loginViewController
        if Auth.auth().currentUser == nil {
            //Show login screen
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.title = "Log In"
            present(vc, animated: false)
        }
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource Realization

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model: HomeFeedRenderViewModel
        if section == 0 {
            model = feedRenderModels[0]
        } else {
            let position = section % 4 == 0 ? section / 4 : ((section - (section % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = section % 4
        if subSection == 0 {
            //Header
            return 1
        } else if subSection == 1 {
            //Post
            return 1
        } else if subSection == 2 {
            //Actions
            return 1
        } else if subSection == 3 {
            //Comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent:
                return 0

            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: HomeFeedRenderViewModel
        if indexPath.section == 0 {
            model = feedRenderModels[0]
        } else {
            let position = indexPath.section % 4 == 0 ? indexPath.section / 4 : ((indexPath.section - (indexPath.section % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = indexPath.section % 4
        if subSection == 0 {
            //Header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier, for: indexPath) as! FeedPostHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                cell.contentView.isUserInteractionEnabled = false
                return cell
            case .comments, .actions, .primaryContent:
                return UITableViewCell()
            }
        } else if subSection == 1 {
            //Post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as! FeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .comments, .actions, .header:
                return UITableViewCell()
            }
        } else if subSection == 2 {
            //Actions
            switch model.actions.renderType {
            case .actions(let action):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionsTableViewCell.identifier, for: indexPath) as! FeedPostActionsTableViewCell
                //            cell.configure()
                cell.delegate = self
                cell.contentView.isUserInteractionEnabled = false
                return cell
            case .comments, .header, .primaryContent:
                return UITableViewCell()
            }
        } else if subSection == 3 {
            //Comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier, for: indexPath) as! FeedPostGeneralTableViewCell
                //            cell.configure()
                return cell
            case .header, .actions, .primaryContent:
                return UITableViewCell()
            }
            
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            return 50
        } else if subSection == 1 {
            return tableView.width
        } else if subSection == 2 {
            return 60
        } else if subSection == 3 {
            return 50
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        return subSection == 3 ? 70 : 0
    }
    
}

//MARK: - FeedPostHeaderTableViewCellDelegate Realization

extension HomeViewController: FeedPostHeaderTableViewCellDelegate {
    
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post Information", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Report Post", style: .destructive, handler: { [weak self] _ in
            self?.reportPost()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in

        }))
        actionSheet.popoverPresentationController?.sourceView = UIView()
        actionSheet.popoverPresentationController?.sourceRect = UIView().bounds
        present(actionSheet, animated: true)
    }
    
    func reportPost() {
        
    }
    
}

//MARK: - FeedPostActionsTableViewCellDelegate Realization

extension HomeViewController: FeedPostActionsTableViewCellDelegate {
   
    func didTapLikeButton() {
        print("like")
    }
    
    func didTapCommentButton() {
        print("comments")
    }
    
    func didTapSendButton() {
        print("send")
    }
    
}
