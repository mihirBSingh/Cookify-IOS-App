//
//  StorageManager.swift
//  Cookify
//
//  Created by jake gilbert on 12/7/23.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    //initialze singleton
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    
    //reference to the USER folder
    private func userReference(userId: String) -> StorageReference {
        return imagesReference.child("users").child(userId)
    }
    
    //reference to folder of user's POSTS so each image path is "images/users/(userId)/(postid)/UUID.jpeg"
    private func postReference(postId: String, userId: String) -> StorageReference {
        return imagesReference.child("users").child(userId).child("posts").child(postId)
    }
    
    
    func saveImage(data: Data, postId: String, userId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        
        let returnedMetaData = try await postReference(postId: postId, userId:userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    
    func getData(postId: String, userId: String, path: String) async throws -> Data{
        try await postReference(postId: postId, userId: userId).child(path).data(maxSize: 3 * 1024 * 1024)

    }
    
    func deleteAll() async throws{
        try await imagesReference.delete()
    }
    
}
