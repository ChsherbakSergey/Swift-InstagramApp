//
//  UserNotification.swift
//  InstagramApp
//
//  Created by Sergey on 12/1/20.
//

import Foundation

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}
