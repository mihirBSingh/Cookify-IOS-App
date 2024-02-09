//
//  Post.swift
//  Cookify
//
//  Created by jake gilbert on 11/27/23.
//

import Foundation


struct PostModel: Decodable {
    let postId: Int
    let postImageURL: String
    let postTitle: String
    let postDescription: String
}
