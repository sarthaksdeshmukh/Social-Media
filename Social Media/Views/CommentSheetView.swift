//
//  commentSheetView.swift
//  Social Media
//
//  Created by Sarthak Deshmukh on 29/10/25.
//

import SwiftUI

struct CommentSheetView: View {
    @State var commentText: String = ""
    let commentHistory: String?
    let id: Int16
    @ObservedObject var feedViewModel: FeedViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Add a Comment")
                .font(.headline)
            
            HStack{
                Text(commentHistory ?? "Nice")
                Spacer()
            }
            
            TextField("Write your comment...", text: $commentText)
                .textFieldStyle(.roundedBorder)
                
            Button(action: {
                feedViewModel.updatePost(id: id, comment: commentText, image: nil, isLike: nil)
                dismiss()
            }) {
                Text("Post Comment")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                   
            }
        }
        .padding()
        .padding(.horizontal)
    }
}

#Preview {
    CommentSheetView(commentText: "", commentHistory: "Nice", id: 2, feedViewModel: FeedViewModel())
}
