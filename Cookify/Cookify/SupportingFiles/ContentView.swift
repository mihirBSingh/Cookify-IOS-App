//
//  ContentView.swift
//  Cookify
//  The best app to eat food on in 2018
//
//  Created by Jamie Hackney, Jake Gilbert, Mihir Singh on 10/6/23.
//


import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var showLoginView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                CookifyTabView(showLoginView: $showLoginView)
            }
        }
        //show tab view if user logged in
        .onAppear {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showLoginView = authUser == nil

        }
        //otherwise, show login screen
        .fullScreenCover(isPresented: $showLoginView){
            NavigationStack {
                LoginScreen(showLoginView: $showLoginView)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
