//
//  DatabaseManager.swift
//  InstagramApp
//
//  Created by Sergey on 11/27/20.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()

    //MARK: - Public functions
    
    ///checks if the user with given username and email is already exists. If exists we don't create an account and if doen't exists we create new user with provided username and email 
    public func canCreateNewAccount(with username: String, email: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    ///Creates new entry in Firebase realtime database with new user and fields like username and email
    public func insertNewUserIntoDatabase(with username: String, email: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username" : username], withCompletionBlock: { error, _ in
            if error == nil {
                //insert data to database
                
                completion(true)
                return
            } else {
                //Failed to write data into database
                print("Error while writing data into database about new user has occured")
                completion(false)
                return
            }
        })
    }
    
}
