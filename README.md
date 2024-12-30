# Simon Says Game

A simple Flutter-based game where players mimic a sequence of flashing colors. The game gets progressively harder as the sequence length increases.

## Features

- **Dynamic Gameplay**: The game generates a random sequence of colors for the player to replicate.
- **Interactive UI**: Each button flashes to indicate the sequence, and players tap to match the pattern.
- **Score Tracking**: The highest score is displayed and updated after each game.
- **Responsive Design**: Button sizes adjust dynamically based on screen dimensions.
- **Elegant Visuals**: Smooth animations and vibrant colors enhance the user experience.

## How to Run

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   ```

2. **Navigate to the Project Directory**:
   ```bash
   cd simon_says_game
   ```

3. **Install Dependencies**:
   Ensure you have Flutter installed. Then run:
   ```bash
   flutter pub get
   ```

4. **Run the Application**:
   ```bash
   flutter run
   ```

## Gameplay Instructions

1. Press the **Play** button to start the game.
2. Watch the sequence of flashing buttons carefully.
3. Tap the buttons in the correct order to match the sequence.
4. The game ends if you press the wrong button.
5. Try to beat your highest score!

## Project Structure

```
lib/
├── main.dart    # Main entry point of the application
```

## Dependencies

- **Flutter SDK**: Ensure you have the latest stable version.
- **Dart**: Comes bundled with Flutter.

## Customization

- **Colors**: Update the `_colors` list in `main.dart` to add or modify the button colors.
- **Speed**: Adjust the delays in `_flashButton` and `_playSequence` to change the game's pace.

## Future Enhancements

- Add levels with increasing difficulty.
- Include sound effects for each button press.
- Implement a leaderboard for competitive gameplay.

## License

This project is licensed under the MIT License. Feel free to use and modify it as per your needs.

---

**Happy Coding!**
