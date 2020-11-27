//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import SafariServices
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
        
        return button
    }()
    
    private let createNewAccountButton : UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create An Account!", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        return button
    }()
    
    private let privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let termsButton : UIButton = {
        let button = UIButton()
        button.setTitle("Terms Of Service", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
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
        //frame of scrollView
        scrollView.frame = view.bounds
        //frame of headerview
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height / 3.0)
        //frame of Username or Email button
        configureHeaderView()
        //frame of user or email button
        usernameOrEmailTextField.frame = CGRect(x: 25,
                                  y: headerView.bottom + 30,
                                  width: view.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of password button
        passwordTextField.frame = CGRect(x: 25,
                                  y: usernameOrEmailTextField.bottom + 10,
                                  width: view.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of log in button
        loginButton.frame = CGRect(x: 25,
                                  y: passwordTextField.bottom + 10,
                                  width: view.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of create an account button
        createNewAccountButton.frame = CGRect(x: 25,
                                  y: loginButton.bottom + 10,
                                  width: view.width - 50,
                                  height: Constants.textFieldHeight)
        //frame of terms button
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width - 20,
                                   height: 50)
        privacyButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 50,
                                   width: view.width - 20,
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
        passwordTextField.resignFirstResponder()
        usernameOrEmailTextField.resignFirstResponder()
        guard let usernameOrEmail = usernameOrEmailTextField.text, !usernameOrEmail.isEmpty,
              let password = passwordTextField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        //Firebase Log in
    }
    
    @objc private func didTapCreateNewAccountButton() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
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
