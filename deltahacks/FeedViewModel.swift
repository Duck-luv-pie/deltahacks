//
//  FeedViewModel.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//
//
//import Foundation
//
//@MainActor
//class FeedViewModel: ObservableObject {
//    @Published var posts: [Post] = []
//
//    func fetchPosts() async {
//        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate delay
//        posts = [
//            Post(id: UUID().uuidString, username: "User1", content: "First post!", timestamp: Date(), likes: 10, isLiked: false, imageData: nil),
//            Post(id: UUID().uuidString, username: "User2", content: "SwiftUI is amazing!", timestamp: Date(), likes: 25, isLiked: false, imageData: nil)
//        ]
//    }
//
//    func addPost(_ post: Post) {
//        posts.insert(post, at: 0) // Add the post to the top of the list
//    }
//}
//
import Foundation
import UIKit

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []

    init() {
        loadInitialPosts() // Load hardcoded posts when the ViewModel is initialized
    }

    // Hardcode three posts
    private func loadInitialPosts() {
        posts = [
//            Post(
//                id: UUID().uuidString,
//                username: "Alice",
//                content: "Just treated myself to the best brunch ever! 🥞☕",
//                timestamp: Date(),
//                likes: 12,
//                isLiked: false,
//                imageData: UIImage(named: "crepe")?.jpegData(compressionQuality: 0.8)
//            ),
            Post(
                id: UUID().uuidString,
                username: "Bob",
                content: "Dinner was lit! 🍝🔥",
                timestamp: Date().addingTimeInterval(-3600), // 1 hour ago
                likes: 34,
                isLiked: true,
                imageData: UIImage(named: "heartpasta")?.jpegData(compressionQuality: 0.8)
            ),
            Post(
                id: UUID().uuidString,
                username: "Charlie",
                content: "Fruit bowls are such a healthy way to start the day! 🍓🍌🥝",
                timestamp: Date().addingTimeInterval(-7200), // 2 hours ago
                likes: 19,
                isLiked: false,
                imageData: UIImage(named: "fruit")?.jpegData(compressionQuality: 0.8)
            )
        ]
    }

    // Allow adding new posts dynamically (e.g., via PostingPage)
    func addPost(_ post: Post) {
        posts.insert(post, at: 0) // Add new posts at the top of the feed
    }
}

