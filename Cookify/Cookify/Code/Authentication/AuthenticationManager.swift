//
//  AuthenticationManager.swift
//  Cookify
//
//  Created by jake gilbert on 11/30/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}


//authentication manager will be a singleton passed through the views to access users
final class AuthenticationManager {
    
    //SINGLETON - get in other views
    static let shared = AuthenticationManager()
    init (){}
    
    
    //create a new user and return its STRUCT
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        //store returned result from auth into a struct
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    
    
    //sign in existing user
    @discardableResult
    func signInExistingUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)

    }
    
    
    
    //get exsiting user
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func getUserId() throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return user.uid
    }
        
    
    
    //SIGN USER OUT
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    
    
    func resetPassword(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        try await user.delete()
    }
    
    
}
