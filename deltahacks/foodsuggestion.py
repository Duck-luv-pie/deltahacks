import cohere

# Initialize Cohere API client
co = cohere.ClientV2(api_key="3JcjPjz2HMeGravtUVl335s4pkmY8VlPDemrUx6h")

# Predefined array of eaten foods
eaten_food = ["Pizza", "Hamburger", "Ice Cream", "Chicken Wing", "Peanuts"]

# Function to generate food ideas using the chat API
def generate_food_ideas(past_foods):
    # Construct the user message with examples
    message = f"""Based on the foods provided below, generate 3 creative new food ideas that are not in the given list:

Eaten foods: {', '.join(past_foods)}

Please format the output as a numbered list, like this:
1. Sushi
2. Salad
3. Tacos
"""

    # Make the Chat API call
    response = co.chat(
        model="command-r-plus-08-2024",  # Replace with the correct model name for your use case
        messages=[{"role": "user", "content": message}],
    )

    # Access the text content of the assistant's response
    raw_response = response.message.content
    suggestions = []

    # Extract text from the content list
    for item in raw_response:
        if hasattr(item, "text"):  # Ensure the item has a 'text' attribute
            suggestions.extend(item.text.strip().split("\n"))  # Split by newlines to extract each suggestion

    # Filter out empty or malformed lines and only keep numbered suggestions
    suggestions = [
        line.split(". ", 1)[-1]
        for line in suggestions
        if line.strip() and line.strip()[0].isdigit()  # Ensure the line starts with a number
    ]

    return suggestions[:3]  # Limit to the top 3 suggestions

# Main function
def main():
    print("Generating 3 new food suggestions based on the foods you've eaten...")
    print("Eaten foods:", eaten_food)

    # Generate new food suggestions
    suggestions = generate_food_ideas(eaten_food)

    # Print the suggestions
    print("\nSuggestions for you to try:")
    print(suggestions)

    # Write the suggestions to a .txt file, each on its own line
    output_file = "food_suggestions.txt"
    with open(output_file, "w", encoding="utf-8") as f:
        for suggestion in suggestions:
            f.write(suggestion + "\n")

    print(f"\nThe suggestions have been saved to {output_file}")

# Run the main function
if __name__ == "__main__":
    main()
