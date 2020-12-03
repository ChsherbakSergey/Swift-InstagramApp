//
//  PostRenderViewModel.swift
//  InstagramApp
//
//  Created by Sergey on 12/1/20.
//

import Foundation

struct PostRenderViewModel {
    let renderType: PostRenderType
}

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [PostComment])
}
