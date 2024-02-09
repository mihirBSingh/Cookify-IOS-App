import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @StateObject var addFriendsModel = AddFriendsModel()
    
    @Binding var showLoginView: Bool

    
    var body: some View {
        NavigationStack {
            HStack(spacing: 10) {
                Text("profile")
                    .fontWeight(.bold)
                    .padding(.leading, 30)
                    .font(.title)
                    .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                    .padding(.top, 5)
                
                Spacer()
                
                NavigationLink(destination: AddFriendsView()) {
                    Image(systemName: "plus.rectangle")
                        .resizable().aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(red: 0.353, green: 0.388, blue: 0.388))
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 15)
                }
                
                NavigationLink(destination: SettingsScreen(showLoginView: $showLoginView)) {
                    Image(systemName: "gear")
                        .resizable().aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(red: 0.353, green: 0.388, blue: 0.388))
                        .frame(width: 35, height: 35)
                        .padding(.trailing, 15)
                }
            }.padding(.bottom, -10)
            
            ScrollView{
                VStack {
                    // top part (profile pic and name)
                    HStack (spacing: 70) {
                        
                        // profile picture
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        
                        VStack (spacing: 15) {
                            
                            HStack (spacing: 15) {
                                
                                VStack (spacing: 10) {
                                    //FOLLOWERS COUNT
                                    Text(String(10))
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                    //FOLLOWERS
                                    Text("followers")
                                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                }
                                
                                VStack (spacing: 10) {
                                    //FOLLOWING COUNT
                                    Text(String(9))
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                    //FOLLOWING
                                    Text("following")
                                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                }
                                
                            }
                        }
                        
                    }.padding(.bottom, 0)
                    
                    HStack {
                        Text("posts")
                            .fontWeight(.bold)
                            .font(.title2)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding(15)
                            .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                        
                        Spacer()
                    }
                    
                    LazyVStack{
                        ForEach(viewModel.userPosts, id: \.self){ post in
                            FeedCell(post: post, user: viewModel.user)
                            //Text(post.postId)
                            //
                            //.frame(minHeight:500)
                        }
                    }
                    
                }
                
                
                Spacer()
                
            }.padding(15)
        }
        .background(Color(red: 0.996, green: 0.961, blue: 0.929))
        .task {
            print("UPDATE")
            try? await viewModel.loadCurrentUser()
            try? await viewModel.getProfileFeed()

            print("EMAIL: \(viewModel.user.email)")

            

    
//            var imageData = [Data]()
//            
//            for post in viewModel.userPosts{
//                if let path =  viewModel.userPosts[0].imageUrls{
//                    let data = StorageManager.shared.getData(postId: post.post, userId: viewModel.user.userId, path: post.)
//                }
//            }
//            
//
//            
        }
        
    }
    
}

#Preview {
    ProfileView(showLoginView: .constant(false))
}
