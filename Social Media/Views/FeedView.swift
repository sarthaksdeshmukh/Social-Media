//
//  FeedView.swift
//  Social Media Feed Application
//
//  Created by Sarthak Deshmukh on 29/10/25.
//

import SwiftUI

import SwiftUI

struct FeedView: View {
    
    @State private var showImagePicker = false
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
          
            VStack {
                List {
                    ForEach(feedViewModel.feedList, id: \.self) { post in
                        FeedCellView(post: post, isLiked: post.isLike ,feedViewModel: feedViewModel)
                            .listRowInsets(EdgeInsets()) // optional, remove padding
                                   .listRowSeparator(.hidden)
                                   .contentShape(Rectangle()) // ensures image only handles its area
                                   .onTapGesture { } // dis
                    }
                }
                .listStyle(.plain)
                Spacer()
                NavigationLink(
                                   destination: PostView(),
                                   isActive: $showImagePicker
                               ) {
                                   VStack {
                                       Image(systemName: "plus.square")
                                       Text("Post")
                                   }
                               }
                
    

            }
            .navigationTitle("Social Media")
            .onAppear {
                feedViewModel.getFeedList()
            }
        }
    }
}

#Preview {
    FeedView()
}
