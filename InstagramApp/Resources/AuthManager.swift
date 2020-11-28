//
//  AuthManager.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    //MARK: - Public functions
    
    ///Register new user based on the information they provided, but call another function from database manager to check if the user exists with provided data.
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        //Firstly check if the username is available and if it is not, show the alert that says it
        //Check if the email is available and if it is not, show the alert that says it
        
        DatabaseManager.shared.canCreateNewAccount(with: username, email: email, completion: { ableToCreate in
            if ableToCreate {
                //Create a new account and then insert its data to database
                Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
                    guard authResult != nil, error == nil else {
                        print("Error creating user has occured")
                        completion(false)
                        return
                    }
                    //Insert data into database
                    DatabaseManager.shared.insertNewUserIntoDatabase(with: username, email: email, completion: { inserted in
                        if inserted {
                            
                            completion(true)
                            return
                        }
                        else {
                            //Failed to insert new user into database
                            completion(false)
                            return
                        }
                    })
                })
            }
            else {
                //show an error why could not create a new account
                completion(false)
            }
        })
    }
    
    ///Log the user in based on what they provided, either email and password or username and password
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        //Log in with email
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        }
        //Log in with username
        else if let username = username {
            print(username)
        }
        
    }
    
    
}
