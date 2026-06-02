# ELmorsy Care - Flutter Mobile Application

This Flutter codebase represents a Clean Architecture implementation of ELmorsy Care home medical services.

## Directory Structure Included:
- `pubspec.yaml` : Product dependencies (Firebase setup, Riverpod for state and Google Maps dependencies)
- `lib/main.dart` : Application entry point with theme configurations
- `lib/domain/entities/nurse.dart` : Clean Arch Entities
- `lib/data/models/nurse_model.dart` : Clean Arch Models and json decoders
- `lib/presentation/providers/booking_provider.dart` : Core riverpod providers for medical bookings states
- `lib/presentation/widgets/custom_button.dart` : Premium UI widgets
- `lib/presentation/screens/home_screen.dart` : Main interactive user explorer screen

## Quick Start:
1. Install Flutter SDK (v3.16+)
2. Run `flutter pub get`
3. To run on Android: Connect your device via USB and run `flutter run`
4. To build release APK: `flutter build apk --release`
