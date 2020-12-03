//
//  EditProfileViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit

class EditProfileViewController: UIViewController {

    //Views that will be displayed on this controller
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    //Constants and variables
    private var models = [[EditProfileFormModel]]()
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        configureNavigationBar()
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the tableview
        tableView.frame = view.bounds
    }
    
    ///Configures models for this view
    private func configureModels() {
        //name, username, website, bio
        let sectionOneLabels = ["Name", "Username", "Bio"]
        var sectionOne = [EditProfileFormModel]()
        for label in sectionOneLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            sectionOne.append(model)
        }
        models.append(sectionOne)
        //Email, phone, gender
        let sectionTwoLabels = ["Email", "Phone", "Gender"]
        var sectionTwo = [EditProfileFormModel]()
        for label in sectionTwoLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            sectionTwo.append(model)
        }
        models.append(sectionTwo)
    }
    
    ///Sets initial UI
    private func setInitialUI() {
        //Background color of the main view
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(tableView)
        //Configure table header view
        tableView.tableHeaderView = configureTableHeaderView()
    }
    
    ///Sets Delegates
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    ///Configures NavigationBar
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancelButton))
    }
    
    ///Configure Table Header View
    private func configureTableHeaderView() -> UIView {
        //Creating mainView
        let header = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: view.width,
                                          height: view.height / 4.0))
        //Creating profile photo button
        let profilePhotoButton = UIButton(frame: CGRect(x: (header.width - header.height / 1.5) / 2,
                                                        y: (header.height - header.height / 1.5) / 2,
                                                        width: header.height / 1.5,
                                                        height: header.height / 1.5))
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = profilePhotoButton.height / 2.0
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.addTarget(self, action: #selector(didTapProfileButtonPicture), for: .touchUpInside)
        //Adding button to the header view
        header.addSubview(profilePhotoButton)
        return header
    }

    @objc private func didTapSaveButton() {
        //Save information into database
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    private func didTapChangeProfilePicture() {
        ActionSheets.createAnAlertWhenDidTapChangeProfilePicture(on: self, with: "Profile Picture", message: "Change Profile Picture")
    }
    
    @objc private func didTapProfileButtonPicture() {
        
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource Realization

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Infromation"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - FormTableViewCellDelegate Realization

extension EditProfileViewController: FormTableViewCellDelegate {
    
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        //Update the model
        print("\(updatedModel.value ?? "")")
    }
    
}
