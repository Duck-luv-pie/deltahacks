import SwiftUI

struct ProfileView: View {
    var streak = 7
    var onLogout: () -> Void // Callback for logout action
    @State private var foodSuggestions: [String] = [] // State to hold food suggestions
    @State private var isShuffleToggled: Bool = false // State to toggle between files

    var body: some View {
        ZStack {
            Color.lightGreen // Light green background
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Profile Section
                    VStack(spacing: 10) {
                        let profileImagePath: String = "/Users/eric/red_panda_img.jpg"
                        if let image = UIImage(contentsOfFile: profileImagePath) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.3)) // Placeholder if image doesn't load
                                .frame(width: 120, height: 120)
                                .overlay(Text("Profile").foregroundColor(.foregroundWhite))
                        }

                        Text("Eric Yoon")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.foregroundWhite)

                        Text("eyoon06@gmail.com")
                            .font(.subheadline)
                            .foregroundColor(.foregroundWhite.opacity(0.7))
                    }
                    .padding(.top, 40)

                    // Streak Section
                    VStack {
                        HStack {
                            Text("Streak")
                                .font(.headline)
                                .foregroundColor(.black)
                            Spacer()
                            Text("\(streak)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                        .padding()
                        .background(Color.foregroundWhite) // White card background
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal)

                    // Suggestions Section
                    VStack(alignment: .leading) {
                        Text("Daily Food Shuffle")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.bottom, 5)

                        if foodSuggestions.isEmpty {
                            Text("Loading suggestions...")
                                .foregroundColor(.foregroundWhite.opacity(0.7))
                                .italic()
                        } else {
                            VStack(spacing: 10) {
                                ForEach(foodSuggestions, id: \.self) { suggestion in
                                    HStack {
                                        Text(suggestion)
                                            .foregroundColor(.black)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.foregroundWhite) // White card background
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Shuffle Button
                    Button(action: {
                        // Toggle the file and reload suggestions
                        isShuffleToggled.toggle()
                        let fileName = isShuffleToggled ? "food_shuffled.txt" : "food_shuffle.txt"
                        loadFoodSuggestions(from: fileName)
                    }) {
                        Text("Shuffle")
                            .font(.headline)
                            .foregroundColor(.foregroundWhite)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "5B714B")) // Dark green button
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)

                    // Log Out Button
                    Button(action: {
                        onLogout() // Trigger the logout action
                    }) {
                        Text("Log Out")
                            .font(.headline)
                            .foregroundColor(.foregroundWhite)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red) // Red logout button
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                }
                .padding()
            }
        }
        .onAppear {
            loadFoodSuggestions(from: "food_suggestions.txt") // Load default suggestions
        }
    }

    // Function to load suggestions from a file
    private func loadFoodSuggestions(from fileName: String) {
        // Define the file path
        let filePath = "/Users/eric/Xcode_Projects/DeltaHacks/deltahacks/deltahacks/\(fileName)"

        // Print the file path being used
        print("Looking for file at path: \(filePath)")

        do {
            // Read the file contents
            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
            print("File Contents: \(fileContents)") // Debug file contents

            // Process the file contents into suggestions
            foodSuggestions = fileContents
                .components(separatedBy: .newlines)
                .filter { !$0.isEmpty } // Remove empty lines

            print("Loaded Suggestions: \(foodSuggestions)") // Debug loaded suggestions
        } catch {
            // Print error if file reading fails
            print("Error reading file at \(filePath): \(error)")
            foodSuggestions = ["No suggestions available"] // Fallback if file load fails
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(onLogout: {})
    }
}
