//
//  Alerts.swift
//  InstagramApp
//
//  Created by Sergey on 11/28/20.
//

import Foundation
import UIKit

class Alerts {

    //MARK: -- Public functiions
    
    private static func createAnAlertWithDoneButton(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }

    public static func loginAlert(on vc: UIViewController) {
        Alerts.createAnAlertWithDoneButton(on: vc, with: "Log In Error", message: "We were unable to Log You In.")
    }
    
    public static func loginAlertEmptyFields(on vc: UIViewController) {
        Alerts.createAnAlertWithDoneButton(on: vc, with: "Log In Error", message: "Please enter all the information to Log In")
    }
    
    public static func loginAlertNotEnoughCharactersInPassword(on vc: UIViewController) {
        Alerts.createAnAlertWithDoneButton(on: vc, with: "Log In Error", message: "Your password must be at least 8 characters long")
    }
    
}
