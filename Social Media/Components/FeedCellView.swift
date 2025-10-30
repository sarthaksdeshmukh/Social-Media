//
//  FeedCellView.swift
//  Social Media Feed Application
//
//  Created by Sarthak Deshmukh on 29/10/25.
//

import SwiftUI

struct FeedCellView: View {
    
    let post: PostEntity
    @State var isLiked: Bool = false
    @State private var showCommentSheet = false
    @State private var showShareSheet = false
    @State private var commentText = ""
    @ObservedObject var feedViewModel: FeedViewModel
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            if let location = post.location {
                Text(location)
                    .font(.subheadline)
                    .padding(.horizontal)
            }
            
            if let img = post.image,let image = UIImage(data: img) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()
                    .contentShape(Rectangle()) // Ensures taps stay within image bounds
            } else {
                Text("No Image Found")
            }
            
            VStack {
                if let description = post.imageDescription {
                    Text(description)
                }else {
                    Text("No description")
                }
            } .font(.caption)
                .padding(10)
            
            HStack(spacing: 20) {
                
                // Like
                Button(action: {
                    withAnimation {
                        isLiked.toggle()
                        feedViewModel.updatePost(id: post.id, comment: nil, image: nil, isLike:  isLiked)
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(post.isLike ? .red : .primary)
                }
                
                // Comment
                Button(action: {
                    showCommentSheet.toggle()
                    feedViewModel.getFeedList()
                }) {
                    Image(systemName: "bubble.right")
                        .font(.title2)
                }
                
                // Share
                Button(action: {
                    showShareSheet.toggle()
                    
                }) {
                    Image(systemName: "paperplane")
                        .font(.title2)
                }
                
                Spacer()
            }.padding(.horizontal)
            
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(height: 20)
        }
        .listRowSeparator(.hidden)
        .contentShape(Rectangle()) // keep shape boundaries
        .allowsHitTesting(true) // ensure internal buttons still work
        .buttonStyle(.plain)
        .sheet(isPresented: $showCommentSheet) {
            CommentSheetView(commentHistory: post.comment, id: post.id, feedViewModel: feedViewModel)
                .presentationDetents([.fraction(0.3)]) // Optional: control height
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [post.imageDescription ?? ""])
        }
    }
}

#Preview {
    FeedCellView(post: PostEntity(), feedViewModel: FeedViewModel())
}
