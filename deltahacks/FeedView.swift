//
//  FeedView.swift
//  dh2
//
//  Created by Sania Shah on 2025-01-11.
//
import SwiftUI

struct FeedView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen // Light green background
                    .ignoresSafeArea()

                VStack {
                    // Header Bar
                    HStack {
                        Text("NutriGram")
                            .font(.custom("Oranienbaum-Regular", size: 28))
                            .foregroundColor(.foregroundWhite) // White color
                            .padding()

                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.backgroundGreen) // Original green
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)

                    // Feed List
                    List($feedViewModel.posts) { $post in
                        PostRow(post: $post)
                            .listRowBackground(Color.clear) // Remove default list background
                            .padding(.vertical, 8)
                            .background(Color.foregroundWhite) // White card background
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                    }
                    .scrollContentBackground(.hidden) // Remove default list background
                }
            }
        }
    }
}
