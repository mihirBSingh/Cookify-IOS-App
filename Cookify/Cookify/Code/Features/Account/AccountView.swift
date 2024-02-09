import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = AccountViewModel()
    
    @Binding var showLoginView: Bool
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("username")
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .font(.title)
                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                    
                    Spacer()
                              
                    NavigationLink(destination: SettingsScreen(showLoginView: $showLoginView)) {
                        Image(systemName: "gear")
                            .resizable().aspectRatio(contentMode: .fit)
                            .foregroundColor(Color(red: 0.353, green: 0.388, blue: 0.388))
                            .frame(width: 35, height: 35)
                        .padding(.trailing, 15)
                    }
                }
                
                // top part (profile pic and name)
                HStack (spacing: 45) {
                    
                    // profile picture
                    Image("bread_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125)
                    
                    VStack (spacing: 15) {
                                                
                        HStack (spacing: 15) {
                            
                            VStack (spacing: 10) {
                                Text("10")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                    .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                
                                Text("followers")
                                    .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                            }
                            
                            VStack (spacing: 10) {
                                Text("20")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                    .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                
                                Text("following")
                                    .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                            }
                            
                        }
                    }
                    
                }.padding(.bottom, 25)
                
                HStack {
                    Text("posts")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .padding(15)
                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                    
                    Spacer()
                }
                
                Spacer()
                
            }.padding(15)
                .background(Color(red: 0.996, green: 0.961, blue: 0.929))
            
        }
        
    }
    
}

#Preview {
    ProfileView(showLoginView: .constant(false))
}
