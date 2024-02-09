//
//  AddFriendsModel.swift
//  Cookify
//
//  Created by Jamie Hackney on 12/11/23.
//

import Foundation

@MainActor
final class AddFriendsModel: ObservableObject {
    
    @Published var addUsername: String = ""
    
    func addFriend() {
        print($addUsername)
    }

}
