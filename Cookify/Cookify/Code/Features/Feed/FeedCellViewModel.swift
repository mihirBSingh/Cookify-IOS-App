//
//  FeedCellViewModel.swift
//  Cookify
//
//  Created by jake gilbert on 12/7/23.
//

import Foundation



final class FeedCellViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
        
    
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)

    }

    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUserData(userId: authDataResult.uid)
    }
    
}
