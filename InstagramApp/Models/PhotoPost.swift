//
//  PhotoPost.swift
//  InstagramApp
//
//  Created by Sergey on 11/29/20.
//

import Foundation

///Represent a user Post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL // either video url or photo url
    let postURL: URL
    let caption: String?
    let likes: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggesUsers: [String]
    let owner: User
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct User {
    let username: String
    let profilePicture: URL
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCounts
    let joinDate: Date
}

enum Gender {
    case male, female, other
}

struct UserCounts {
    let followers: Int
    let following: Int
    let posts: Int
}
