//
//  RegistrationViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit
import SafariServices

class RegistrationViewController: UIViewController {
    
    //Views that will be use on this controller
    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let usernameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username..."
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
    
    private let emailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Adress..."
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
        textField.textContentType = .newPassword
        return textField
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
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

    ///Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        assignDelegates()
        setTargetsToButtons()
        dismissTextFieldsWhenTapOutsideOfIt()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //Frame of the scrollView
        scrollView.frame = view.bounds
        //Frame of the username textfield
        usernameTextField.frame = CGRect(x: 25,
                                         y: scrollView.safeAreaInsets.top + 100,
                                         width: scrollView.width - 50,
                                         height: 52)
        //Frame of the email textfield
        emailTextField.frame = CGRect(x: 25,
                                      y: usernameTextField.bottom + 10,
                                         width: scrollView.width - 50,
                                         height: 52)
        //Frmae of the password textfield
        passwordTextField.frame = CGRect(x: 25,
                                      y: emailTextField.bottom + 10,
                                         width: scrollView.width - 50,
                                         height: 52)
        //Frame of the register button
        registerButton.frame = CGRect(x: 25,
                                      y: passwordTextField.bottom + 10,
                                         width: scrollView.width - 50,
                                         height: 52)
        //Frame of the privacy policy button
        privacyButton.frame = CGRect(x: 10,
                                   y: scrollView.height - scrollView.safeAreaInsets.bottom - 100,
                                   width: scrollView.width - 20,
                                   height: 50)
        //Frame of the terms button
        termsButton.frame = CGRect(x: 10,
                                   y: scrollView.height - scrollView.safeAreaInsets.bottom - 150,
                                   width: scrollView.width - 20,
                                   height: 50)
    }
    
    ///Sets Initial UI
    private func setInitialUI() {
        //Assign background of the main view
        view.backgroundColor = .systemBackground
        //Adding scrollview to the view
        view.addSubview(scrollView)
        //Adding other elements to the scrollView
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(registerButton)
        scrollView.addSubview(privacyButton)
        scrollView.addSubview(termsButton)
    }
    
    ///Sets delegates
    private func assignDelegates() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    ///Dismiss keyboard when the user taps outside of it
    private func dismissTextFieldsWhenTapOutsideOfIt() {
        //adding gesture to scrollview to be able to dismiss keyboard when tap outside of the textfield
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOutsideOfTextfields))
        gesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(gesture)
    }
    
    ///Dismiss keyabord
    @objc private func didTapOutsideOfTextfields() {
        scrollView.endEditing(true)
    }
    
    ///Sets Targets to buttons on the screen
    private func setTargetsToButtons() {
        //Adding targets to the buttons
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    }
    
    ///Register the user
    @objc private func didTapRegisterButton() {
        //Firstly resign all the textfields respinders
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        //check if the information provided by a user is correspond to the information we need to register an user. And if it conforms - we register an user, otherwise we show them an alerts that correspond to why we cannot register them.
        if let username = usernameTextField.text, !username.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty, password.count >= 8 {
            //Firebase register
            AuthManager.shared.registerNewUser(username: username, email: email, password: password, completion: { [weak self] registered in
                DispatchQueue.main.async {
                    if registered {
                        //dismiss controller and show the app to the user
                        self?.dismiss(animated: true, completion: nil)
                    }
                    else {
                        //Unable to register a new user. Show the alert that says why
                    }
                }
            })
        }
        //Add an Alert if an user did not enter all the information or if an user did not passed a valid password or if an user was unable to log in with 3 attempts show the forgot password alert;
        else if let emptyUsername = usernameTextField.text,
                let emptyEmail = emailTextField.text,
                let emptyPassword = passwordTextField.text,
                    emptyUsername.isEmpty || emptyEmail.isEmpty || emptyPassword.isEmpty  {
            Alerts.loginAlertEmptyFields(on: self)
        } else if let notEnoughtCharactersInPassword = passwordTextField.text, notEnoughtCharactersInPassword.count < 8 {
            Alerts.loginAlertNotEnoughCharactersInPassword(on: self)
        }
    }
    
    ///Shows Privacy Policy of the app
    @objc private func didTapPrivacyPolicyButton() {
        presentSafariVC(with: "https://help.instagram.com/519522125107875")
    }
    
    ///Shows Terms Of Use of the app
    @objc private func didTapTermsButton() {
        presentSafariVC(with: "https://www.instagram.com/about/legal/terms/before-january-19-2013/")
    }
    
    ///Presents Safari VC with a provided url
    private func presentSafariVC(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}

//MARK: - TextField Delegate Realization

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapRegisterButton()
        }
        return true
    }
    
}
