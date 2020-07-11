import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:location_mapper_macos/location_mapper.dart';
import 'package:location_mapper_macos/utils.dart';

void main() {
  GoogleMap.init('YOUR_API_KEY');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locations = getLocationsList(context);
    return MaterialApp(
      title: 'Locations Mapper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LocationMapper(
        zoomLevel: 13,
        locationsFuture: locations,
      ),
    );
  }
}
