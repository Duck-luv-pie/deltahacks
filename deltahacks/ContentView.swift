import SwiftUI
import Auth0


struct ContentView: View {
  
  @StateObject private var feedViewModel = FeedViewModel()
  @State private var isAuthenticated = false
  @State var userProfile = Profile.empty
  
  var body: some View {
      if isAuthenticated {
                  MainTabView(onLogout: {
                      logout() // Pass the logout function
                  })
                  .environmentObject(feedViewModel) // Inject the ViewModel
              } else {
                  ZStack {
                              Color.lightGreen // Light green background
                                  .ignoresSafeArea()

                              VStack(spacing: 20) {
                                  // NutriGram Logo
                                  if let image = UIImage(contentsOfFile: "/Users/eric/NutriGram_Logo.png") {
                                      Image(uiImage: image)
                                          .resizable()
                                          .scaledToFit()
                                          .frame(width: 200, height: 200) // Adjust size if needed
                                          .cornerRadius(10)
                                  } else {
                                      RoundedRectangle(cornerRadius: 10)
                                          .fill(Color.gray.opacity(0.2))
                                          .frame(width: 200, height: 200)
                                          .overlay(Text("Logo Not Found").foregroundColor(.foregroundWhite))
                                  }

                                  Spacer().frame(height: 20)

                                  // Welcome Text
                                  Text("Welcome to NutriGram")
                                      .modifier(TitleStyle())
                                      .foregroundColor(Color(hex: "5B714B"))
                                  Spacer().frame(height: 20)

                                  // Login Button
                                  Button("Log in") {
                                      login()
                                  }
                                  .buttonStyle(MyButtonStyle())
                              }
                              .padding()
                          }
                      
              }
          }
    //this comment is for testing
  
  
  struct UserImage: View {
    var urlString: String
    var body: some View {
      AsyncImage(url: URL(string: urlString)) { image in
        image
          .frame(maxWidth: 128)
      } placeholder: {
        Image(systemName: "person.circle.fill")
          .resizable()
          .scaledToFit()
          .frame(maxWidth: 128)
          .foregroundColor(.blue)
          .opacity(0.5)
      }
      .padding(40)
    }
  }

    struct TitleStyle: ViewModifier {
        let darkGreen = Color(hex: "5B714B") // Use your dark green color

        func body(content: Content) -> some View {
            content
                .font(.title.weight(.bold))
                .foregroundColor(darkGreen) // Set text color to dark green
                .padding()
        }
    }

  
    struct MyButtonStyle: ButtonStyle {
        let darkGreen = Color(hex: "5B714B") // Use your dark green color

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(darkGreen) // Set button background to dark green
                .foregroundColor(.white) // Set text color to white
                .clipShape(Capsule())
        }
    }

  
}


extension ContentView {
  
  func login() {
    Auth0
      .webAuth()
      .start { result in
        switch result {
          case .failure(let error):
            print("Failed with: \(error)")

          case .success(let credentials):
            self.isAuthenticated = true
            self.userProfile = Profile.from(credentials.idToken)
            print("Credentials: \(credentials)")
            print("ID token: \(credentials.idToken)")
        }
      }
  }
  
  func logout() {
    Auth0
      .webAuth()
      .clearSession { result in
        switch result {
          case .success:
            self.isAuthenticated = false
            self.userProfile = Profile.empty

          case .failure(let error):
            print("Failed with: \(error)")
        }
      }
  }
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
