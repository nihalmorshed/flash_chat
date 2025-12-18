# Flash Chat

A real-time messaging application built with Flutter and Firebase.

## Features

- User registration and authentication
- Real-time messaging with instant updates
- Visual distinction between sent and received messages
- Smooth animations and modern UI design
- Cross-platform support (Android, iOS, Web, Desktop)

## Tech Stack

- **Flutter** - Cross-platform UI framework
- **Firebase Auth** - User authentication
- **Cloud Firestore** - Real-time database
- **Animated Text Kit** - Text animations

## Getting Started

### Prerequisites

- Flutter SDK (>=2.19.6)
- Firebase project with Auth and Firestore enabled

### Installation

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd flash_chat
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase:

   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Email/Password authentication
   - Create a Firestore database
   - Download and add your `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point and routing
├── constants.dart         # UI constants and styling
└── screens/
    ├── welcome.dart       # Welcome screen with animations
    ├── login_screen.dart  # User login
    ├── reg_screen.dart    # User registration
    ├── chat_screen.dart   # Main chat interface
    └── padding_button.dart # Reusable button component
```

## Usage

1. **Register** - Create an account with email and password
2. **Login** - Sign in with your credentials
3. **Chat** - Send and receive messages in real-time
4. **Logout** - Sign out using the logout button in the app bar

## License

This project is open source and available under the MIT License.
