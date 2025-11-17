How to run (local Flutter dev)

1. Ensure Flutter is installed: https://flutter.dev/docs/get-started/install
2. From project root run:

```bash
flutter pub get
flutter run -d chrome   # run as web app for quick smoke test
```

Notes
- `pubspec.yaml` is minimal and references `assets/sample_data.json`.
- If you plan to run on iOS/Android, open the project in Android Studio or Xcode and configure platform-specific bundle identifiers.
