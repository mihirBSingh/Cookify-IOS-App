//
//  FeedCell.swift
//  Cookify
//
//  Created by Mihir Singh on 11/22/23.
//

// TODO: need to make it so that when you click on the profile image you go to that person's account.
// TODO: need to make it so that comments populate
// TODO: need to make it so that your own comment populates and updates in firebase
// TODO: need to make it so that your own like updates in firebase
import Foundation
import SwiftUI
import FirebaseFirestore

struct FeedCell: View{
    
    //GETTING POST AND USER OBJECT FROM PROFILEVIEW OR FEEDVIEW
    var post: DBPost
    var user: DBUser
    
    @StateObject var viewModel = FeedCellViewModel()
    
    @State private var imageData: Data? = nil
    
    //info from initial post
    //@State var accountName = "postId"
    //@State var accountImageLink = "JT-Chocolate-Chip-Cookies-articleLarge"
    //@State var postImageLinks = [String]()
    //@State var prepTime = 0
    //@State var cookTime = 0
    //@State var servings = 0
    //@State var postTitle = "Made Cookies with Jake"
    //@State var description = "Cookies are so delicious. I love eating them"
    //@State var time = "4/4/2023"
    //info after people have interacted with the post
    @State var numLikes = 0
    @State var numComments = 0
        //@State public var listComments = [comment]()
    @State public var listComments = [comment(commentId: 0,
                                              commentAccountImageURL: "JT-Chocolate-Chip-Cookies-articleLarge",
                                              comment: "hehehe",
                                              commentAccount: "jamie"),
                                      comment(commentId: 1,
                                              commentAccountImageURL: "JT-Chocolate-Chip-Cookies-articleLarge",
                                              comment: "they are tasty",
                                              commentAccount: "jake")
                                     ]
    //info describing someone's interactions with the post
    @State private var showingCommentSection = false
    @State private var liked = false
    //dummy images for now
    let imageNames = ["JT-Chocolate-Chip-Cookies-articleLarge", "JT-Chocolate-Chip-Cookies-articleLarge","flour"]
    let imageNameMock = "JT-Chocolate-Chip-Cookies-articleLarge"
    var body: some View{
        //NavigationView{
        VStack {
            //profile info + location info
            HStack {
                NavigationLink(destination: toggledCommentView()){
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .foregroundStyle(.black)
                }
                
                VStack(alignment: .leading){
                    Text("jakeg43")
                        .font(.footnote)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Date: ").font(.footnote).fontWeight(.semibold).foregroundColor(.gray) + Text(viewModel.formatDate(date: post.date.dateValue())).font(.footnote).foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.leading)
            //Post Title
            VStack{
                Text(post.postTitle)
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top, 1)
                    .padding(.trailing)
                //description
                Text(post.postDescription)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.trailing)
            }
            //recipe info
            DisclosureGroup("Recipe Info"){
                HStack{
                    Text("Prep Time")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.semibold)
                        .underline()
                    Text("Cook Time")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.semibold)
                        .underline()
                    Text("Servings")
                        .frame(maxWidth: .infinity)
                        .fontWeight(.semibold)
                        .underline()
                }
                HStack{
                    Text(String(post.prepTime))
                        .frame(maxWidth: .infinity)
                    Text(String(post.cookTime))
                        .frame(maxWidth: .infinity)
                    Text(String(post.servings))
                        .frame(maxWidth: .infinity)
                }
            }
            .listRowInsets(EdgeInsets())
            .padding(.trailing)
            .padding(.leading)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            //image slider
            VStack{
                if let imageData, let image = UIImage(data: imageData){
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Rectangle())
                            .cornerRadius(15)
                            .frame(maxWidth: 363)
                }
                
                //ImageCarouselView(images: imageNames, postId: post.postId, userId: user.userId)
                // ScrollView(.horizontal, showsIndicators: true){
//                 TabView{
//                     ForEach(imageNames, id: \.self){ image in
//                         
//                     }
//                     .padding(.leading)
//                     .padding(.trailing)
//                     
//                 }
//                 .frame(maxHeight:240)
//                 .tabViewStyle(PageTabViewStyle())
//                 .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))

            }
            .frame(minHeight: 240)
            .padding(.bottom, 4)
            .task{
                
                //ON LOAD OF VIEW, get user, then set the data to the user's imageurl
                let userId = try? AuthenticationManager.shared.getUserId()
                var imageUrl = ""
                for image in post.imageUrls{
                    imageUrl = image
                }
                            
                print("Postid: \(post.postId)")
                print("userId: \(userId!)")
                print("IMAGE URL: \(imageUrl)")

                let data = try? await StorageManager.shared.getData(postId: post.postId, userId: userId!, path: imageUrl)
                self.imageData = data
                

            }
            //buttons
            HStack{
                Button{
                    print("Like")
                    if(liked ==  false){
                        numLikes = numLikes + 1
                        liked = true
                    }
                    else{
                        numLikes -= 1
                        liked = false
                    }
                    
                } label: {
                    if(liked == false){
                        Image(systemName: "heart")
                            .foregroundStyle(.black)
                    }
                    else{
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.black)
                    }
                }
                Button {
                    print("Comment")
                    showingCommentSection.toggle()
                } label: {
                    Image(systemName: "message")
                        .foregroundStyle(.black)
                }
                .sheet(isPresented: $showingCommentSection){
                    toggledCommentView()
                        .presentationDetents([.medium, .large])
                    
                }
                Spacer()
            }
            .padding(.leading)
            .padding(.top, 1)
            //kudos info + comments info
            VStack{
                Text(String(numLikes) + " complements to the chef")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
                Button{
                    showingCommentSection.toggle()
                }
                label: {
                    Text("View " + String(numComments) + " comments")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.black)
                }
            }
            .padding(.leading)
            //underline (used to separate posts
            Divider()
                .frame(height: 2)
                .overlay(.black)
                .padding(.bottom, 6)
        }
    } //end of overarching vertical stack
//}end of nav view
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View{
        FeedCell(post: DBPost(), user: DBUser())
    }
}

//struct ImageCarouselView: View{
//    let images: [String]
//    let postId: String
//    let userId: String
//    @StateObject var carouselViewModel = ImageCarouselViewModel()
//
//    var body: some View{
//       
//    }
//}

//toggled comment section view
struct toggledCommentView: View{
    var commentNumber = 10
    @State private var addedComment = ""
    @State var commentToStore = ""
    var body: some View{
        //list of comments
        let fC = FeedCell(post: DBPost(), user: DBUser())
        ScrollView{
            LazyVStack{
                Spacer(minLength: 20)
//                ForEach(0...1, id: \.self){ post in
//                    singleCommentView()
//                        .padding(.leading)
//                        .padding(.trailing)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Spacer()
//                }
                ForEach(fC.listComments.indices, id: \.self){index in
                    let newComment = fC.listComments[index]
                    singleCommentView.init(
                        scvImage: newComment.commentAccountImageURL,
                        scvAccount: newComment.commentAccount,
                        scvIndividualComment: newComment.comment)
                        .padding(.leading)
                        .padding(.trailing)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    //newComment.commentAccountImageURL
                }
            }
            Spacer()
            Divider()
                .frame(height: 2)
                .overlay(.black)
            TextField(
                "Add a Comment",
                text:$addedComment
                
            )
            .onSubmit {
                commentToStore = addedComment
                addedComment = ""
            }
            .padding(.leading)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
                .frame(height: 2)
                .overlay(.black)
                .padding(.bottom, 6)
        }
        .background(Color(red: 0.996, green: 0.961, blue: 0.929))
        
    }
}

//comment layout view
struct singleCommentView: View{
    @State var scvImage = ""
    @State var scvAccount = ""
    @State var scvIndividualComment = ""
    var body: some View{
        VStack {
            //profile info + location info
            HStack {
                Image(scvImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text(scvAccount)
                        .font(.footnote)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(scvIndividualComment)
                        .font(.footnote)
                }
                Spacer()
            }
        }
        Spacer()
        
    }
}

//comment structure
struct comment  {
    let commentId: Int
    let commentAccountImageURL: String
    let comment: String
    let commentAccount: String
    
    func tostring() -> String{
        return commentAccountImageURL
    }
}



