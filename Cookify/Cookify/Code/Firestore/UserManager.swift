//
//  UserManager.swift
//  Cookify
//
//  Created by jake gilbert on 12/3/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct DBUser: Codable {
    let userId: String
    let email: String
    let photoUrl: String
    let posts: [String]
    let followers: [String]
    let following: [String]
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email!
        self.photoUrl = auth.photoUrl!
        self.posts = []
        self.followers = []
        self.following = []
    }
    
    init(){
        self.userId = ""
        self.email = ""
        self.photoUrl = ""
        self.posts = []
        self.followers = []
        self.following = []

    }
}

final class UserManager {
    
    
    //initialze singleton
    static let shared = UserManager()
    private init() {}
    
    
    //get collection and doc
    private let userCollection = Firestore.firestore().collection("users")
    private func userDoc(userId: String) -> DocumentReference {
        userCollection.document(userId)
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
    
    
    
    //CREATE NEW USER IN FIRESTORE
    func createNewUser(user: DBUser) async throws {
        try userDoc(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
    }
    
    //GET USER FROM FIRESTORE
    func getUserData(userId: String) async throws -> DBUser {
        try await userDoc(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
        
    }
    
    //add post (via postId) after uploading
    func updatePosts(postId: String, userId: String) async throws {
        try await userDoc(userId: userId).updateData([
            "posts": FieldValue.arrayUnion([postId])
        ])
    }
    
//    func updaingFollowing(userId: String, email: String) async throws {
//        let snapshot = try await userCollection.whereField("email", isEqualTo: email).getDocuments()
//        
//        for document in snapshot.documents {
//            document.get
//            
//            let data: [String:Any] = [
//                "following": FieldValue.arrayUnion([document.data().])
//            ]
//        }
//        
//        
//        try await userDoc(userId: userId).updateData(data)
//    }
    
    
//    func getUser(userId: String) async throws -> DBUser {
//        
//        let snapshot = try await userDoc(userId: userId).getDocument()
//        
//        guard let data = snapshot.data() else {
//            throw URLError(.badServerResponse)
//        }
//        
//        let userId = data["user_id"] as! String
//        let email = data["email"] as? String
//        let photoUrl = data["photo_Url"] as? String
//        let posts = data["posts"] as? [String]
//        let followers = data["followers"] as? [String]
//        let following = data["following"] as? [String]
//        
//        
//        return DBUser(userId: userId, email: email, photoUrl: photoUrl, posts: posts, followers: followers, following: following)
//    }
    

    
}
