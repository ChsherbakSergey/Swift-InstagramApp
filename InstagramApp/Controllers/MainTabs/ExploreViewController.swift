//
//  ExploreViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit

///Controller that represents explore functionality
final class ExploreViewController: UIViewController {

    //Views that will be displayed on this controller
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let dimmedView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0.4
        return view
    }()
    
    private var collectionView : UICollectionView?
    
    private var tabbedSearchCollectionView : UICollectionView?
    
    //Constants and variables
    private var models = [UserPost]()
    
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
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }

    private func setInitialUI() {
        //background color of the main view
        view.backgroundColor = .systemBackground
        configureExploreCollectionView()
        configureDimmedView()
        configureTabbedSearchCollectionView()
    }
    
    private func configureTabbedSearchCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.backgroundColor = .systemBlue
        tabbedSearchCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
        }
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        view.addSubview(tabbedSearchCollectionView)
    }
    
    private func configureDimmedView() {
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    private func configureExploreCollectionView() {
        //Setting CollectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4) / 3, height: (view.width - 4) / 3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.backgroundColor = .systemBackground
        //Adding collectionView into the main view
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    @objc private func didCancelSearch() {
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    private func setDelegates() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
        searchBar.delegate = self
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout and UICollectionViewDataSource Realization

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
//            return UICollectionViewCell()
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
//        cell.congigure(with: )
        cell.configure(debug: "squareImage")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabbedSearchCollectionView {
            //change search context
            return
        }
        collectionView.deselectItem(at: indexPath, animated: true)
//        let model = models[indexPath.row]
        let user = User(username: "", profilePicture: URL(string: "htttps:/www.google.com/")!, bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCounts(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "udhueh", postType: .photo, thumbnailImage: URL(string: "htttps:/www.google.com/")!, postURL: URL(string: "htttps:/www.google.com/")!, caption: "", likes: [], comments: [], createdDate: Date(), taggesUsers: [], owner: user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: - UISearchBarDelegate Realization

extension ExploreViewController: UISearchBarDelegate {
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didTapCancelSearch()
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        query(text)
    }
    
    private func query(_ text: String) {
        //Perform the search
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let barButton = UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(didTapCancelSearch))
        barButton.tintColor = .label
        navigationItem.rightBarButtonItem = barButton
        
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }) { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }
    
    @objc private func didTapCancelSearch() {
        searchBar.text = ""
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0
        }) { done in
            if done {
                self.dimmedView.isHidden = true
            }
            
        }
    }
    
}
