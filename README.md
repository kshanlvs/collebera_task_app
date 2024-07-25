# Flutter Product List App

This Flutter app displays a list of products from a mock API, shows product details, and allows users to add products to a cart. This app is designed to evaluate coding skills, architecture, state management, and Flutter proficiency.

## Requirements

### App Structure

- **Product List Screen**: Displays a list of products with a thumbnail, name, and price. Implements pull-to-refresh.
- **Product Detail Screen**: Shows detailed information (image, name, price, description) with an "Add to Cart" button.
- **Cart Screen**: Displays the list of added products with the total price and an option to remove items.

### API Integration

- Uses a mock API to fetch product data.

## Setup Instructions

1. **Clone the Repository**
    ```bash
    git clone <https://github.com/kshanlvs/collebera_task_app.git>
    cd <collebera_task_app>
    ```

2. **Install Dependencies**
    ```bash
    flutter pub get
    ```

3. **Run the App**
    ```bash
    flutter run
    ```

## Architecture Explanation

The app follows a MVC (Model View Controller) pattern:

- **Presentation Layer**: Contains UI code (Screens, Widgets).
- **Application Layer**: Contains state management and business logic.
- **Data Layer**: Handles API interactions and data models.

## State Management

This project uses Provider for managing the state of the application.

## API Integration

The app fetches product data from a mock API. The API responses are handled and parsed in the data layer.

## UI/UX

The app provides a smooth and intuitive user interface, making use of Flutter's ListView, Navigator, and other widgets to enhance user experience.

## Code Quality

The project follows Flutter and Dart best practices, ensuring the code is clean, readable, and maintainable.

