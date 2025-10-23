# RandomizerApp - Favorite Items 🎯

A UIKit-based iOS application that displays random favorite items from various categories.

## 🌟 Theme: Mixed Favorites

The app features a diverse collection of favorite items across different categories:

### Item Collection (10 Categories):
- Favorite Car
- Favorite Cat Breed  
- Favorite Sport
- Favorite Book
- Favorite Flower
- Favorite Song
- Favorite Dog
- Favorite Season
- Favorite Color
- Favorite Scent

## 📱 Devices Tested

- **iPhone SE (3rd generation)** - Compact display
- **iPhone 15 Pro Max** - Large display

## 🛠 Technical Implementation

### Code Structure
- **ViewController**: Manages UI updates and random selection logic
- **Arrays**: Two synchronized arrays for images and titles
- **Random Generation**: Uses `Int.random(in: 0..<favouriteImages.count)`

### UI Components
- **Favourite (UIImageView)**: Displays random item images
- **Name (UILabel)**: Shows corresponding item title
- **Randomize (UIButton)**: Triggers new random selection

### Auto Layout Features
- Responsive constraints for all screen sizes
- Safe area guides implementation
- Proper content hugging priorities
- Consistent spacing and positioning

