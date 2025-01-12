import SwiftUI

@main
struct iOS_SwiftUI_LoginApp: App {
    init() {
            // Set the Tab Bar background color to white
            UITabBar.appearance().backgroundColor = UIColor.white
            UITabBar.appearance().isTranslucent = true // Ensure it's solid white
        }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
