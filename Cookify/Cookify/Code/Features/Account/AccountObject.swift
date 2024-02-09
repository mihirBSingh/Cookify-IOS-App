////
////  AccountModel.swift
////  Cookify
////
////  Created by jake gilbert on 11/4/23.
////
////  The model that stores user's data
//
//import Foundation
//
//
//final class AccountObject: ObservableObject {
//    var username = ""
//    var email = ""
//    var password = ""
//    var id = -1
//    
//    //Followers and following are arrays of other users' ids
//    var followers = [Int]()
//    var following =  [Int]()
//    
//    //array of post objects
//    var posts = [PostModel]()
//    
//    
//    
//    func populate(with acct: AccountModel) {
//        username = acct.username
//        password = acct.password
//        email = acct.email
//        id = acct.id
//        
//        followers = acct.followers
//        following = acct.following
//        
//        posts = acct.posts
//    }
//
//}
