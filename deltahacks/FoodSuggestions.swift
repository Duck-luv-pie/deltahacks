//import Foundation
//
//// Function to fetch food suggestions using the Cohere API
//func generateFoodIdeas(eatenFoods: [String], completion: @escaping ([String]) -> Void) {
//    let apiKey = "3JcjPjz2HMeGravtUVl335s4pkmY8VlPDemrUx6h" // Your Cohere API key
//    let endpoint = "https://api.cohere.ai/v1/chat" // Cohere chat endpoint
//    
//    // Construct the message (prompt) to send to Cohere
//    let prompt = """
//    Based on the foods provided below, generate 3 creative new food ideas that are not in the given list:
//
//    Eaten foods: \(eatenFoods.joined(separator: ", "))
//
//    Please format the output as a numbered list, like this:
//    1. Sushi
//    2. Salad
//    3. Tacos
//    """
//    
//    // Define the JSON payload for the API request
//    let payload: [String: Any] = [
//        "model": "command-r-plus-08-2024", // Replace with the correct model name
//        "messages": [
//            ["role": "user", "content": prompt]
//        ]
//    ]
//    
//    // Convert the payload to JSON data
//    guard let jsonData = try? JSONSerialization.data(withJSONObject: payload) else {
//        print("Error serializing JSON")
//        completion([])
//        return
//    }
//    
//    // Create the URL request
//    guard let url = URL(string: endpoint) else {
//        print("Invalid URL")
//        completion([])
//        return
//    }
//    
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//    request.httpBody = jsonData
//    
//    // Send the request using URLSession
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let error = error {
//            print("Error making API request: \(error)")
//            completion([])
//            return
//        }
//        
//        guard let data = data else {
//            print("No data received")
//            completion([])
//            return
//        }
//        
//        do {
//            // Decode the response JSON
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//               let messageArray = json["message"] as? [[String: Any]],
//               let content = messageArray.first?["content"] as? String {
//                // Process the content to extract suggestions
//                let suggestions = content
//                    .split(separator: "\n")
//                    .compactMap { line -> String? in
//                        guard line.first?.isNumber == true else { return nil } // Ensure the line starts with a number
//                        return line.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: true).last?.trimmingCharacters(in: .whitespaces)
//                    }
//                completion(suggestions)
//            } else {
//                print("Invalid response format")
//                completion([])
//            }
//        } catch {
//            print("Error decoding response: \(error)")
//            completion([])
//        }
//    }.resume()
//}
