import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel // Use the shared instance
    let onLogout: () -> Void // Logout callback function

    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "house")
                }

            PostingPage()
                .tabItem {
                    Label("Post", systemImage: "plus.square")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }

            ProfileView(onLogout: onLogout) // Pass the onLogout function
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
