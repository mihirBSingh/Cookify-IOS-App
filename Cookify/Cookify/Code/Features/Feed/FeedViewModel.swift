//
//  FeedViewModel.swift
//  Cookify
//
//  Created by jake gilbert on 12/8/23.
//

import Foundation


@MainActor
final class FeedViewModel: ObservableObject {
    
    @Published var user: DBUser = DBUser()
    
    @Published var userPosts = [DBPost]()
    
    

    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        let user = try await UserManager.shared.getUserData(userId: authDataResult.uid)
        self.user = user
    }
    
    func getProfileFeed () async throws {
        self.userPosts = try await PostManager.shared.getUserDocuments()
    }
    

    
}
