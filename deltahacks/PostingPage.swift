import SwiftUI
import PhotosUI

struct PostingPage: View {
    @State private var content: String = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @EnvironmentObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color.lightGreen // Light green background
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // Show selected image or placeholder
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 200)
                            .overlay(Text("No Image Selected").foregroundColor(.black))
                            .padding()
                    }

                    // PhotosPicker
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Label("Select a Photo", systemImage: "photo")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.backgroundGreen) // Matches FeedView header background
                            .foregroundColor(.foregroundWhite)
                            .cornerRadius(8)
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self),
                               let uiImage = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.selectedImage = uiImage
                                }
                            }
                        }
                    }

                    // TextField for content
                    TextField("Write something...", text: $content)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .background(Color.foregroundWhite) // Matches post cards in FeedView
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)

                    // Post button
                    Button(action: {
                        if let selectedImage = selectedImage, let imageData = selectedImage.jpegData(compressionQuality: 0.8) {
                            let newPost = Post(
                                id: UUID().uuidString,
                                username: "Eric Yoon",
                                content: content,
                                timestamp: Date(),
                                likes: 0,
                                isLiked: false,
                                imageData: imageData // Attach image data
                            )
                            feedViewModel.addPost(newPost)

                            // Reset state
                            content = ""
                            self.selectedImage = nil
                        }
                    }) {
                        Text("Post")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.backgroundGreen) // Matches FeedView header background
                            .foregroundColor(.foregroundWhite)
                            .cornerRadius(8)
                    }
                    .padding()

                    Spacer()
                }
                .navigationTitle("Create Post")
                .padding()
            }
        }
    }
}
