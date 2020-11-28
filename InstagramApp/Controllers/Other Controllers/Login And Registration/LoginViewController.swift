//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import SafariServices
import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let headerView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "instagram-gradient"))
        view.addSubview(backgroundImageView)
        return view
    }()
    
    private let usernameOrEmailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username or Email..."
        textField.returnKeyType = .next
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password..."
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadius
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        return textField
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .link
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        return button
    }()
    
    private let createNewAccountButton : UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create An Account!", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
        return button
    }()
    
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
        return button
    }()
    
    private let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 16)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setInititalUI()
        setTargetsToButtons()
        assignDelegates()
        dismissTextFieldWhenTapOutsideOfIt()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //frame of the scrollView
        scrollView.frame = view.bounds
        //frame of the headerview
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: scrollView.width,
                                  height: scrollView.height / 3.0)
        //frame of the Username or Email button
        configureHeaderView()
        //frame of the user or email button
        usernameOrEmailTextField.frame = CGRect(x: 25,
                                  y: headerView.bottom + 30,
                                  width: scrollView.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of the password button
        passwordTextField.frame = CGRect(x: 25,
                                  y: usernameOrEmailTextField.bottom + 10,
                                  width: scrollView.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of the log in button
        loginButton.frame = CGRect(x: 25,
                                  y: passwordTextField.bottom + 10,
                                  width: scrollView.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of the create an account button
        createNewAccountButton.frame = CGRect(x: 25,
                                  y: loginButton.bottom + 10,
                                  width: scrollView.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of the terms button
        termsButton.frame = CGRect(x: 10,
                                   y: scrollView.height -
                                    scrollView.safeAreaInsets.bottom - 100,
                                   width: scrollView.width - 20,
                                   height: 50)
        //frame of the privacy policy button
        privacyButton.frame = CGRect(x: 10,
                                   y: scrollView.height - scrollView.safeAreaInsets.bottom - 50,
                                   width: scrollView.width - 20,
                                   height: 50)
    }
    
    private func setInititalUI() {
        //Assign background color to the main view
        view.backgroundColor = .systemBackground
        //adding scrollView to the main view
        view.addSubview(scrollView)
        //Adding all the elements to the scrollView
        scrollView.addSubview(headerView)
        scrollView.addSubview(usernameOrEmailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(createNewAccountButton)
        scrollView.addSubview(privacyButton)
        scrollView.addSubview(termsButton)
        //Coinfigure header view
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //Add instagram logo
        let imageView = UIImageView(image: UIImage(named: "instagram-logo"))
        imageView.contentMode = .scaleAspectFit
        headerView.addSubview(imageView)
        imageView.frame = CGRect(x: headerView.width / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width / 2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func assignDelegates() {
        usernameOrEmailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setTargetsToButtons() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createNewAccountButton.addTarget(self, action: #selector(didTapCreateNewAccountButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
    }
    
    private func dismissTextFieldWhenTapOutsideOfIt() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutsideTextField))
        gesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapOutsideTextField() {
        scrollView.endEditing(true)
    }
    
    @objc private func didTapLoginButton() {
        //Resign responders of the textfields
        passwordTextField.resignFirstResponder()
        usernameOrEmailTextField.resignFirstResponder()
        //check if the information provided by a user is correspond to the information we need to log an user in. And if it conforms - we log and user in, otherwise we show them an alerts that correspond to why we cannot log an user in.
        if let usernameOrEmail = usernameOrEmailTextField.text, !usernameOrEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8 {
            //Firebase Log in
            var username: String?
            var email: String?
            //First check if the user tries to log in with email or username
            if usernameOrEmail.contains("@"), usernameOrEmail.contains(".") {
                //Tries to log In with email
                email = usernameOrEmail
            } else {
                //Tries to log in with username
                username = usernameOrEmail
            }
            //Actually log in a user
            AuthManager.shared.loginUser(username: username, email: email, password: password, completion: { [weak self] success in
                //guard a weak self
                guard let strongSelf = self else {
                    return
                }
                if success {
                    //User is logged in
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    //An error while tried to log in occured
                    Alerts.loginAlert(on: strongSelf)
                }
            })
        }
        //Add an Alert if an user did not enter all the information or if an user did not passed a valid password or if an user was unable to log in with 3 attempts show the forgot password alert;
        else if let emptyUserName = usernameOrEmailTextField.text, let emptyPassword = passwordTextField.text, emptyUserName.isEmpty || emptyPassword.isEmpty  {
            Alerts.loginAlertEmptyFields(on: self)
        } else if let notEnoughtCharactersInPassword = passwordTextField.text, notEnoughtCharactersInPassword.count < 8 {
            Alerts.loginAlertNotEnoughCharactersInPassword(on: self)
        }
        
    }
    
    @objc private func didTapCreateNewAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create An Account"
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        presentSafariVC(with: "https://help.instagram.com/519522125107875")
    }
    
    @objc private func didTapTermButton() {
        presentSafariVC(with: "https://www.instagram.com/about/legal/terms/before-january-19-2013/")
    }
    
    private func presentSafariVC(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameOrEmailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
    
}
