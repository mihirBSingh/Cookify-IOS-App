//
//  ImageCarouselViewModel.swift
//  Cookify
//
//  Created by jake gilbert on 12/8/23.
//

import Foundation



final class ImageCarouselViewModel: ObservableObject {
    
    @Published var postImages = [Data]()

    
    //load images from a SINGULAR POST
    func loadImages(postId: String, userId: String, imageUrls: [String]) async throws {
        self.postImages.removeAll()
        for imageUrl in imageUrls {
            print("URL")
            print(imageUrl)
            let imageData = try await StorageManager.shared.getData(postId: postId, userId: userId, path: imageUrl)
            self.postImages.append(imageData)
        }
        
    }
    
    
}
