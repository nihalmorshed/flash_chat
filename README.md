# Flash Chat ⚡️

A real-time chat application built with Flutter and Firebase. Flash Chat enables users to register, log in, and exchange messages in a group chat environment with a modern, animated interface.

## Features

- User authentication (registration and login) using Firebase Auth
- Real-time messaging using Cloud Firestore
- Animated text and transitions
- Modern UI with custom message bubbles
- Auto-scrolling chat interface
- User-specific message styling
- Loading state indicators
- Error handling with user-friendly alerts

## Technologies Used

- Flutter (SDK >=2.19.6 <3.0.0)
- Firebase Authentication
- Cloud Firestore
- Animated Text Kit package
- Modal Progress HUD package

## Project Structure

```
lib/
├── screens/
│   ├── welcome.dart         # Welcome screen with animations
│   ├── login_screen.dart    # User login interface
│   ├── reg_screen.dart      # User registration interface
│   ├── chat_screen.dart     # Main chat interface
│   └── padding_button.dart  # Reusable button widget
├── constants.dart           # UI constants and styles│
└── main.dart                # main dart file

```

## Getting Started

### Prerequisites

- Flutter (>=2.19.6)
- Firebase account and project
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
```bash
git clone [your-repository-link]
```

2. Navigate to the project directory
```bash
cd flash_chat
```

3. Install dependencies
```bash
flutter pub get
```

4. Configure Firebase
   - Create a new Firebase project
   - Add your Android/iOS app in Firebase console
   - Download and add the configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS
   - Enable Email/Password authentication in Firebase console
   - Create Cloud Firestore database

5. Run the application
```bash
flutter run
```

## Dependencies

```yaml
dependencies:
  animated_text_kit: ^4.2.2
  firebase_auth: ^4.4.1
  cloud_firestore: ^4.5.1
  firebase_core: ^2.9.0
  modal_progress_hud: ^0.1.3
```

## Usage

1. Launch the app and create a new account or log in
2. Messages are displayed in real-time with different colors for sent and received messages
3. Use the logout button in the chat screen to sign out

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Acknowledgments

- Flutter development team
- Firebase team
