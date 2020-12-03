//
//  ActionSheets.swift
//  InstagramApp
//
//  Created by Sergey on 11/28/20.
//

import Foundation
import UIKit

class ActionSheets {
    
    //MARK: -- Public functiions
    
    public static func createAnActionSheetWhenLogOut(on vc: UIViewController, with title: String, message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logout(completion: { loggedOut in
                DispatchQueue.main.async {
                    if loggedOut {
                        //Successfully logged the user out and than display log in view controller
                        let LoginVC = LoginViewController()
                        LoginVC.modalPresentationStyle = .fullScreen
                        LoginVC.title = "Log In"
                        vc.present(LoginVC, animated: true, completion: {
                            vc.navigationController?.popToRootViewController(animated: false)
                            vc.tabBarController?.selectedIndex = 0
                        })
                    }
                    //Something went wrong and user was not logged out successfully
                    else {
                        print("Error while logging out the user has occured")
                    }
                }
            })
        }))
        DispatchQueue.main.async {
            actionSheet.popoverPresentationController?.sourceView = UIView()
            actionSheet.popoverPresentationController?.sourceRect = UIView().bounds
            vc.present(actionSheet, animated: true)
        }
    }
    
    public static func createAnAlertWhenDidTapChangeProfilePicture(on vc: UIViewController, with title: String, message: String) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
            
        }))
        DispatchQueue.main.async {
            actionSheet.popoverPresentationController?.sourceView = UIView()
            actionSheet.popoverPresentationController?.sourceRect = UIView().bounds
            vc.present(actionSheet, animated: true)
        }
    }
    
    
    
    
}
