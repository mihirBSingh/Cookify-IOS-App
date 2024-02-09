//
//  CookifyTabView.swift
//  Cookify
//
//  Created by jake gilbert on 10/29/23.
//

import SwiftUI

struct CookifyTabView: View {
    
    //pass down bool to settings screen to log user out
    @Binding var showLoginView: Bool
    
    var body: some View {
        TabView{
            FeedView()
                .tabItem {
                    Image(systemName: "square.stack")
                    Text("Feed")
                }
            RecordRecipeView()
                .tabItem {
                    Image(systemName: "carrot")
                    Text("Record")
                }
            ProfileView(showLoginView: $showLoginView)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    CookifyTabView(showLoginView: .constant(false))
}
