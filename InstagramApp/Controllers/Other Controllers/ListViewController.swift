//
//  ListViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit

class ListViewController: UIViewController {

    //Views that will be displayed on this controller
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowTableViewCell.self, forCellReuseIdentifier: UserFollowTableViewCell.identifier)
        return tableView
    }()
    
    //Constans and Variables
    private var data = [UserRelationship]()
    
    
    init(data: [UserRelationship]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //frame of the table
        tableView.frame = view.bounds
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //Background color of the main view
        view.backgroundColor = .systemBackground
        //Adding sibviews
        view.addSubview(tableView)
    }
    
    ///Sets delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: - UITableViewDelegate and UITableViewDataSource Realization

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.identifier, for: indexPath) as! UserFollowTableViewCell
        cell.delegate = self
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Go to the profile of the selected cell
        
        let model = data[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

//MARK: - UserFollowTableViewCellDelegate Realization

extension ListViewController: UserFollowTableViewCellDelegate {
    
    func didTapFollowOrUnfollowButton(model: UserRelationship) {
        switch model.followType {
        case .following:
            //Unfollow user
            break
        case .not_following:
            //Lollow user
            break
        }
    }
    
}
