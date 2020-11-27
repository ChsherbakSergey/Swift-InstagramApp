//
//  ViewController.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        handleNotAuthenticatedUser()
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

