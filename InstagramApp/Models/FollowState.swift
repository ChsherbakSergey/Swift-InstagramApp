//
//  FollowState.swift
//  InstagramApp
//
//  Created by Sergey on 12/1/20.
//

import Foundation

enum FollowState {
    case following, not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let followType: FollowState
}
