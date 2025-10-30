//
//  PostView.swift
//  Social Media Feed Application
//
//  Created by Sarthak Deshmukh on 29/10/25.
//

import SwiftUI

struct PostView: View {
    
    @State private var descriptionText = ""
    @State private var locationText = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    @StateObject var postViewModel = PostViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 300)
                    .overlay(
                        Text("Tap to select image")
                            .foregroundColor(.gray)
                    )
                    .onTapGesture {
                        showImagePicker.toggle()
                    }
            }
            
            
            VStack(alignment: .leading){
                Text("Location")
                    .font(.subheadline)
                TextField("Enter Location...", text: $locationText, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
                
            VStack(alignment: .leading){
                Text("Description")
                    .font(.subheadline)
                TextField("Enter description...", text: $descriptionText, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   
            }
            
            Button(action: {
                postViewModel.savePost(id:  Int16(Int.random(in: 1...1_000)),selectedImage: selectedImage, comment: nil, isLike: false, description: descriptionText, location: locationText)
                dismiss()
            }) {
                Text("Post")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(selectedImage != nil ? Color.blue : Color.gray)
                    .cornerRadius(10)
            }
            .disabled(selectedImage == nil)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Create Post")
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

#Preview {
    PostView()
}
