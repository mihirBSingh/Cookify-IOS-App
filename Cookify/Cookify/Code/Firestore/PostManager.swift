//
//  PostManager.swift
//  Cookify
//
//  Created by jake gilbert on 12/5/23.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift



struct DBPost: Codable, Hashable {
    //let id: String
    let posterId: String
    var postId: String
    let postTitle: String
    let postDescription: String
    let imageUrls: [String]

    
    let date: Timestamp
    let prepTime: String
    let cookTime: String
    let servings: Int
    
    var comments: [String]
    var likedBy: [String]
    
    
    //EMPTY INIT FOR PREVIEWS
    init() {
        self.posterId = ""
        self.postId = ""
        self.postTitle = ""
        self.postDescription = ""
        self.imageUrls = []
        
        self.date = Timestamp()
        self.prepTime = ""
        self.cookTime = ""
        self.servings = 0
        
        self.comments = []
        self.likedBy = []
    }
    
    init(posterId: String, postId: String, postTitle: String, postDescription: String, imageUrls: [String], date: Timestamp, prepTime: String, cookTime: String, servings: Int, comments: [String], likedBy: [String]) {
        self.posterId = posterId
        self.postId = postId
        self.postTitle = postTitle
        self.postDescription = postDescription
        self.imageUrls = imageUrls
        
        self.date = date
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.servings = servings
        
        self.comments = comments
        self.likedBy = likedBy
    }
}



final class PostManager {
    
    //initialze singleton
    static let shared = PostManager()
    private init() {}
    
    
    
    private let postCollection = Firestore.firestore().collection("posts")
    private func postDoc(postId: String) -> DocumentReference {
        postCollection.document(postId)
    }
    
    //convert camel case to snake case
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    //returns new doc reference when uploading - GENERATES NEW ID
    func newPostRef() async throws -> DocumentReference {
        return postCollection.document()
    }
    
    func uploadPost(post: DBPost) async throws {
        try postDoc(postId: post.postId).setData(from: post, merge: false, encoder: encoder)
        
    }
    
    func getPost(postId: String) async throws -> DBPost {
        let docRef = postDoc(postId: postId)
        return try await docRef.getDocument(as: DBPost.self, decoder: decoder)
    }
    
    
    func getUserDocuments() async throws -> [DBPost]{
        let userId = try AuthenticationManager.shared.getAuthenticatedUser().uid
        let snapshot = try await postCollection.whereField("poster_id", isEqualTo: userId).getDocuments()
        
        var posts: [DBPost] = []
        for document in snapshot.documents {
            let post = try document.data(as: DBPost.self, decoder: decoder)
            posts.append(post)
        }
        posts = posts.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
        
        //limits teh amt of posts to the most recent 10
        if(posts.count > 10){
            posts = Array(posts[0...9])
        }
        
        return posts
    }
    
    
    
    
}
//func getPost(userId: String) async throws -> DBPost {
//    let snapshot = try await userDoc(userId: userId).getDocument()
//    
//    guard let data = snapshot.data() else {
//        throw URLError(.badServerResponse)
//    }
//    
//    let posterId = data["poster_id"] as? String
//    let postId = data["post_id"] as? String
//    let postTitle = data["post"] as? String
//    let postDescription = data["post_description"] as? String
//    let photoUrl = data["photo_url"] as? String
//
//    
//    let date = data["date"] as? String
//    let prepTime = data["prep_time"] as? String
//    let cookTime = data["cook_time"] as? String
//    let servings = data["servings"] as? Int
//    
//    let comments = data["comments"] as? [String]
//    let likedBy = data["liked_by"] as? [String]
//    
//    return DBPost(posterId: posterId, postId: postId, postTitle: postTitle, postDescription: postDescription, imageUrl: imageUrl, date: date, prepTime: prepTime, cookTime: cookTime, servings: servings, comments: comments, likedBy: likedBy)
//}
