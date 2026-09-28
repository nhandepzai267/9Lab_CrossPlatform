# Lab 5 - Xylophone 🎵

A simple xylophone app built with Flutter as part of Lab 5, demonstrating how to use third-party Dart packages to speed up development.

## Features

- 7 colorful xylophone keys (Red → Purple)
- Tap any key to play a musical note
- Smooth, responsive UI built entirely with Flutter widgets

## Packages Used

- [`audioplayers`](https://pub.dev/packages/audioplayers) — plays multiple audio files simultaneously on Android, iOS, and Web

## How It Works

Each key is a colored `GestureDetector` widget wrapped in an `Expanded` layout. When tapped, it creates an `AudioPlayer` instance and streams the corresponding note via `UrlSource`.

## Getting Started

```bash
flutter pub get
flutter run
```

## Tech Stack

- **Flutter** SDK
- **Dart** language
- `audioplayers: ^6.8.1`
