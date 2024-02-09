import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore

struct RecordRecipeView: View {
    
    
    @StateObject private var viewModel = RecordRecipeViewModel()

    // posting function object
    @StateObject var posting: RecipePosting = RecipePosting()
    
    // timer objects
    @ObservedObject var prep_timer: RecipeTimer = RecipeTimer()
    @ObservedObject var cook_timer: RecipeTimer = RecipeTimer()
      
    var body: some View {
        
        // background color vstack
        VStack {
            
            ScrollView{
                        
                // all content vstack
                VStack(spacing: 20) {
                    
                    Text("Whats Cookin?")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                    
                    
                    TextField(
                        "dish name",
                        text: $viewModel.meal_title
                    )
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 0.6, green: 0.655, blue: 0.6), lineWidth: 3)
                    )
                    
                    TextField(
                        "dish description",
                        text: $viewModel.description,
                        axis: .vertical
                    )
                    .lineLimit(3)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 0.6, green: 0.655, blue: 0.6), lineWidth: 3)
                    )
                    
                    HStack {
                        Text("Servings:")
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                        
                        Picker("", selection: $viewModel.serves) {
                            ForEach(1...10, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: 100, height: 100)
                    }
                    
                    HStack {
                    
                        VStack(spacing: 20) {
                            Text("Prep Timer")
                                .fontWeight(.bold)
                                .font(.title2)
                                .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                            
                            Button(action: {
                                self.prep_timer.isRunning.toggle()
                            }) {
                                VStack {
                                    
                                    self.playPauseTextPrep
                                    
                                    Text(self.elapsedTimeStr(timeInterval: self.prep_timer.elapsedTime))
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                }
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.6, green: 0.655, blue: 0.6))
                                .frame(width: 150, height: 90)
                            )
                            
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 20) {
                            Text("Cook Timer")
                                .fontWeight(.bold)
                                .font(.title2)
                                .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                            
                            Button(action: {
                                self.cook_timer.isRunning.toggle()
                            }) {
                                VStack {
                                    
                                    self.playPauseTextCook
                                    
                                    Text(self.elapsedTimeStr(timeInterval: self.cook_timer.elapsedTime))
                                        .fontWeight(.bold)
                                        .font(.title2)
                                        .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                                }
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.6, green: 0.655, blue: 0.6))
                                .frame(width: 150, height: 90)
                            )
                            
                        }
                        
                    }.padding([.leading, .trailing, .bottom], 20)
                    
                    
                    PhotosPicker(selection: $viewModel.imageSelections, maxSelectionCount: 1, matching: .images, photoLibrary: .shared())
                    {
                        Text("Show the People!")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                            .padding(20)
                            .background(RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 0.6, green: 0.655, blue: 0.6))
                            )
                        
                    }
                    
                    Spacer()
                    
                    if !$viewModel.images.isEmpty {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<viewModel.images.count, id: \.self) { index in
                                    let scaledImage = viewModel.images[index]
                                    scaledImage
                                        .resizable()
                                        .aspectRatio(
                                            contentMode: .fill
                                        )
                                        .frame(
                                            width: 200,
                                            height: 300
                                        )
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button{
                        Task{
                            do{
                                try? await StorageManager.shared.deleteAll()

                                print(self.elapsedTimeStr(timeInterval: self.prep_timer.elapsedTime))
                                print(self.elapsedTimeStr(timeInterval: self.cook_timer.elapsedTime))
                                
                                //CREATE NEW POST ID REFERENCE
                                let userId = try AuthenticationManager.shared.getAuthenticatedUser().uid
                                let newPostId = try await PostManager.shared.newPostRef().documentID
                                
                                
                                //UPLOAD IMAGES AND GET THEIR PATHS
                                var imageURLS = [String]()
                                for image in viewModel.imageSelections{
                                    imageURLS.append(try await viewModel.saveImages(item: image, postId: newPostId, userId: userId))
                                }
                                
                                //UPLOAD RECIPE WITH NEW POSTID AND PATHS
                                if(imageURLS.count != 0){
                                    try await viewModel.uploadRecipe(
                                        prepTime: self.elapsedTimeStr(timeInterval: self.prep_timer.elapsedTime),
                                        cookTime: self.elapsedTimeStr(timeInterval: self.cook_timer.elapsedTime),
                                        postId: newPostId,
                                        userId: userId,
                                        imageURLS: imageURLS
                                    )
                                }
                                else{
                                    print("no image selected")
                                }
                                
                                
                            }
                            catch{
                                print(error)
                            }
                        }

                    } label: {
                        Text("Serve!")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
                            .frame(maxWidth: .infinity)
                    }
                    .padding(20)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.6, green: 0.655, blue: 0.6))
                    )
                    
                }
                .padding([.top, .leading, .trailing], 20)
            
            }
            
        }
        .background(Color(red: 0.996, green: 0.961, blue: 0.929))
        .onTapGesture {
            self.hideKeyboard()
        }
        
    }
    
    static var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .hour, .minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]
        formatter.allowsFractionalUnits = true
        return formatter
    }()
    
    private var playPauseTextPrep: Text {
        return Text(self.prep_timer.isRunning ? "stop":"start")
            .fontWeight(.bold)
            .font(.title2)
            .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
    }
    
    private var playPauseTextCook: Text {
        return Text(self.cook_timer.isRunning ? "stop":"start")
            .fontWeight(.bold)
            .font(.title2)
            .foregroundStyle(Color(red: 0.353, green: 0.388, blue: 0.388))
    }
    
    private func elapsedTimeStr(timeInterval: TimeInterval) -> String {
        return RecordRecipeView.formatter.string(from: timeInterval) ?? ""
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        RecordRecipeView()
    }
}
