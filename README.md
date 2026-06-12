# HypeSneakers

An exclusive sneaker store app built with Flutter and Material Design 3.

## Brand

- **Name:** HypeSneakers
- **Primary Color:** Purple (#7C4DFF)
- **Theme:** Material 3

## Features

- **Browse Sneakers** — Explore curated sneaker collection
- **Search & Filter** — Find sneakers by brand, category, or keyword
- **Shopping Cart** — Add and manage items before checkout
- **User Authentication** — Sign in with Google, Apple, or email/password
- **Firebase Backend** — Real-time data sync, auth, and cloud storage

## Architecture

MVVM with Provider state management:
- **Services/** — AppState, Firebase services
- **Auth/** — Authentication pages and logic
- **Models/** — Data models
- **UI/** — Screens and widgets

## Stack

- **Framework:** Flutter / Dart
- **State Management:** Provider
- **Backend:** Firebase (Auth, Firestore)
- **Auth:** Google Sign-In, Sign in with Apple, Email/Password
- **Design:** Material Design 3 with Cupertino widgets

## Firebase Setup

1. Create a Firebase project at [firebase.google.com](https://firebase.google.com)
2. Enable **Authentication** (Google, Apple, Email), **Cloud Firestore**, and **Firebase Cloud Messaging**
3. Download and place `google-services.json` in `android/app/` and `GoogleService-Info.plist` in `ios/`
4. Run `flutterfire configure` to regenerate `lib/firebase_options.dart`

## CI/CD

This project uses GitHub Actions for continuous integration. On every push and pull request to `main`:

- `flutter pub get` — Install dependencies
- `flutter analyze` — Static analysis
- `flutter test` — Run tests

## Build

```bash
flutter pub get
flutter run                          # Run on connected device/emulator
flutter build apk --debug            # Debug APK
flutter build apk --release          # Release APK
flutter build ios --no-codesign      # iOS build (unsigned)
```

## Deploy

### Android
1. Bump version in `pubspec.yaml`
2. Run `flutter build apk --release` or `flutter build appbundle --release`
3. Upload to Google Play Console

### iOS
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select **Product > Archive**
3. Upload to App Store Connect via Xcode Organizer

## License

MIT
