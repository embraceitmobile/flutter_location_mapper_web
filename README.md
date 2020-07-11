# location_mapper_web_app

A Flutter app for loading location coordinates from assets file and drawing markers on the map for analysis.

*Note:* This project will only run on flutter beta channel.

#### To get started
____________________

1. Add your Google MAPS API key enabled for JavaScript here:

```dart
void main() {
  GoogleMap.init('YOUR_API_KEY');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
```

2. Add API key in index.html file present in web directory:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>flutter_google_maps_example</title>
</head>
<body>
  <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY"></script>
  <script src="main.dart.js" type="application/javascript"></script>
</body>
</html>
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
