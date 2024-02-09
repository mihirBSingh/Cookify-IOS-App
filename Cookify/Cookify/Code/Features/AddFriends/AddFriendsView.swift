//
//  AddFriendsView.swift
//  Cookify
//
//  Created by Jamie Hackney on 12/11/23.
//

import SwiftUI

struct AddFriendsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var viewModel = AddFriendsModel()
    
    var body: some View {
        
        VStack() {
            
            Text("enter their username")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
            
            TextField(
                "username",
                text: $viewModel.addUsername
            )
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 0.6, green: 0.655, blue: 0.6), lineWidth: 3)
            )
            
            Button {
                Task {
                    do {
                        viewModel.addFriend()
                    }
                }
            } label: {
                Text("add friend")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                    .frame(maxWidth: .infinity)
            }
            .padding(20)
            .background(RoundedRectangle(cornerRadius: 16)
                .fill(Color(red: 0.6, green: 0.655, blue: 0.6))
            )
            
            Spacer()
            
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
        .padding(15)
        .background(Color(red: 0.996, green: 0.961, blue: 0.929))
                
    }
}

#Preview {
    AddFriendsView()
}
