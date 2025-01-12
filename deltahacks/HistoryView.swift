import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationView {
            ZStack {
                // Green background
                Color.lightGreen
                    .ignoresSafeArea()

                // List overlay
                List {
                    ForEach(feedViewModel.posts.filter { $0.username == "Eric Yoon" }, id: \.id) { post in
                        PostRow(post: .constant(post))
                            .listRowBackground(Color.white) // Make list row background transparent
                    }
                }
                .scrollContentBackground(.hidden) // Remove the default background of the List
            }
            .navigationTitle("Your Posts")
        }
    }
}
