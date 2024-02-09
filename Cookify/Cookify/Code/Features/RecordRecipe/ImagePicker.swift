//
//  ImagePicker.swift
//  Cookify
//
//  Created by Jamie Hackney on 11/28/23.
//

import SwiftUI
import PhotosUI
import Foundation

@MainActor
class ImagePicker: ObservableObject {
    
    @Published var images: [Image] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task {
                self.images.removeAll()
                if !imageSelections.isEmpty {
                    try await loadTransferrable(from: imageSelections)
                }
            }
        }
    }
    
    
    func loadTransferrable(from imageSelections: [PhotosPickerItem]) async throws {
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
    
}
