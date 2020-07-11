import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final String lat;
  final String lon;

  Location({this.lat, this.lon});

  LatLng getLatLng() {
    return LatLng(double.parse(lat), double.parse(lon));
  }
}
