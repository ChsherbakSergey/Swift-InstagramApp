//
//  ProfileViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit
import FirebaseAuth

///Profile View Controller that represents the user's profile
final class ProfileViewController: UIViewController {
    
    //Views that will be displayed on this controller
    
    private var collectionView : UICollectionView?
    
    //Constants and Variables
    private var userPosts = [UserPost]()
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        configureNavigationBar()
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the collectionView
        collectionView?.frame = view.bounds
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //Background color of the main view
        view.backgroundColor = .systemBackground
        //Setting CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: (view.width - 4) / 3,
                                 height: (view.width - 4) / 3)
        collectionView?.backgroundColor = .systemBackground
        //Cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        //Headers
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        //Adding collectionView into the main view
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    ///Sets right bar button to the navigation controller
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    ///Shows the user settings controller
    @objc private func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///Sets delegates
    private func setDelegates() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout and UICollectionViewDataSource Realization

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
//        return userPosts.count
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
//        cell.congigure(with: model)
        cell.configure(debug: "squareImage")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //Get the model and then open post controller
//        let model = userPosts[indexPath.row]
        let user = User(username: "", profilePicture: URL(string: "htttps:/www.google.com/")!, bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCounts(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "udhueh", postType: .photo, thumbnailImage: URL(string: "htttps:/www.google.com/")!, postURL: URL(string: "htttps:/www.google.com/")!, caption: "", likes: [], comments: [], createdDate: Date(), taggesUsers: [], owner: user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            //Tries to find footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            //Tabs Header
            let tabsHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            tabsHeader.delegate = self
            
            return tabsHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height / 3)
        }
        //Size of section Tabs
        return CGSize(width: collectionView.width, height: 35)
    }
    
}

//MARK: - ProfileInfoHeaderCollectionReusableViewDelegate Realization

extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        //Scroll to the post section
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for i in 0..<10 {
            mockData.append(UserRelationship(username: "iamsergeychsherbak", name: "Sergey Chsherbak", followType: i % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for i in 0..<10 {
            mockData.append(UserRelationship(username: "iamsergeychsherbak", name: "Sergey Chsherbak", followType: i % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
}

//MARK: - ProfileTabsCollectionReusableViewDelegate Realization

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    
    func didTapGridButtonTab() {
        //Reload collectionView with data
    }
    
    func didTapTaggedButtonTab() {
        //Reload collectionView with data
    }
    
}
