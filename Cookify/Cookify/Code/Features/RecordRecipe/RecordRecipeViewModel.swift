//
//  RecordRecipeViewModel.swift
//  Cookify
//
//  Created by jake gilbert on 12/5/23.
//

import SwiftUI
import Foundation
import PhotosUI
import Combine
import Firebase

final class RecordRecipeViewModel: ObservableObject {
    
    // recipe information
    @Published var meal_title: String = ""
    @Published var description: String = ""
    @Published var serves: Int = 0
    
    
    //DATE FORMATTER
    private func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        return dateFormatter.string(from: date)
    }
    
    
    

    //IMAGES

    //images in Image type form to display on the view
    @Published var images: [Image] = []
    
    //array of photopickeritems that will be turned into data objects for saveImage
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task {
                self.images.removeAll()
                if !imageSelections.isEmpty {
                    try await addToImages(from: imageSelections)
                }
            }
        }
    }
    
    func addToImages(from imageSelections: [PhotosPickerItem]) async throws {
        do {
            for imageSelection in imageSelections {
                if let data = try await imageSelection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.images.append(Image(uiImage: uiImage))
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    //UPLOAD POST
    func uploadRecipe(prepTime: String, cookTime: String, postId: String, userId: String, imageURLS: [String]) async throws{
        
        let post = DBPost(//id: postId,
                          posterId: userId,
                          postId: postId,
                          postTitle: self.meal_title,
                          postDescription: self.description,
                          imageUrls: imageURLS,
                          date: Timestamp(),
                          prepTime: prepTime,
                          cookTime: cookTime,
                          servings: self.serves,
                          comments: [],
                          likedBy: []
        )
        
        
        let docs = try await PostManager.shared.getUserDocuments()

        if(meal_title != "" && description != ""){
            //upload to POSTS
            try await PostManager.shared.uploadPost(post: post)
            
            //update USER
            try await UserManager.shared.updatePosts(postId: postId, userId: userId)
        }
    }
    
    //SAVE IMAGE
    
    func saveImages(item: PhotosPickerItem, postId: String, userId: String) async throws -> String{
        guard let data = try await item.loadTransferable(type: Data.self) else { return ""}
        let (path, name) = try await StorageManager.shared.saveImage(data: data, postId: postId, userId: userId)

        return name

    }
    

    
    
    
}
