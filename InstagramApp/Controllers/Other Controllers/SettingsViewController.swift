//
//  SettingsViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit
import SafariServices
import FirebaseAuth

///View controller tthat shows user settings
final class SettingsViewController: UIViewController {

    //Views that will be used on this controller
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //Constants and variables
    private var data = [[SettingsCellModel]]()
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the tableview
        tableView.frame = view.bounds
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Adding tableView to the main view
        view.addSubview(tableView)
    }
    
    ///Sets delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Sets the models
    private func configureModels() {
        data.append([
            SettingsCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingsCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingsCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapSaveOriginalPosts()
            })
        ])
        data.append([
            SettingsCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openUrl(type: .terms)
            }),
            SettingsCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openUrl(type: .privacy)
            }),
            SettingsCellModel(title: "Help / Feedback", handler: { [weak self] in
                self?.openUrl(type: .help)
            })
        ])
        data.append([
            SettingsCellModel(title: "Log Out", handler: { [weak self] in
                self?.logout()
            })
        ])
    }
    
    ///Presents the action sheet and if user tap log out it logs the user out
    private func logout() {
        ActionSheets.createAnActionSheetWhenLogOut(on: self, with: "Log Out", message: "Are you sure you want to Log Out?")
    }
    
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    private func didTapInviteFriends() {
        //Show share sheets to invite friends
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    ///Opens Safari VC with url that depends on which cell user has tapped
    private func openUrl(type: SettingsUrlType) {
        let urlString : String
        switch type {
        case .terms: urlString = "https://www.instagram.com/about/legal/terms/before-january-19-2013/"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
        }
        presentSafariVC(with: urlString)
    }
    
    ///Presents Safari VC to be able to see anything with a provided url
    private func presentSafariVC(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}

//MARK: - TableView Delegate And TableView DataSource Realization
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Model
        let model = data[indexPath.section][indexPath.row]
        model.handler()
    }
    
    
}
