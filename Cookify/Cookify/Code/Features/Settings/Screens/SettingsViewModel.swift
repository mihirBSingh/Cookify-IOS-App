//
//  SettingsViewModel.swift
//  Cookify
//
//  Created by jake gilbert on 11/30/23.
//

import Foundation



@MainActor
final class SettingsViewModel: ObservableObject {
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
        
    }
}
