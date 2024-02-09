//
//  SettingsScreen.swift
//  Cookify
//
//  Created by Jamie Hackney on 10/30/23.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = SettingsViewModel()
    
    //CHECK IF USER IS SIGNED IN BINDING FROM CONTENTVIEW
    @Binding var showLoginView: Bool
    
    @State private var showResetPasswordAlert = false

    
    var body: some View {
        Text("Settings").bold()
        List {
            Button("Log Out") {
                Task {
                    do {
                        //log out and go back to login view
                        try viewModel.logOut()
                        showLoginView = true
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Reset password") {
                Task {
                    do {
                        showResetPasswordAlert = true
                        try await viewModel.resetPassword()
                    } catch {
                        print(error)
                    }
                }
            }
            .alert(isPresented: $showResetPasswordAlert) {
                Alert(title: Text("Password reset sent"))
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showLoginView = true
                    } catch {
                        print(error)

                    }
                }
            } label: {
                Text("Delete Account")
            }
        }
        
        
        
        // back to sign up button
        Text("back to profile")
            .font(.system(size: 15))
            .frame(maxWidth: .infinity, maxHeight: 60)
            .foregroundColor(Color(red: 0.6, green: 0.655, blue: 0.6))
            .underline()
            .onTapGesture {
                self.presentationMode.wrappedValue.dismiss()
            }
    }
}

#Preview {
    SettingsScreen(showLoginView: .constant(false))
}
