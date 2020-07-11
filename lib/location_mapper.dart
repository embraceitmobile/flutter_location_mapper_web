import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

import 'location_model.dart';

class LocationMapper extends StatefulWidget {
  final double zoomLevel;
  final Future<List<Location>> locationsFuture;

  LocationMapper({
    Key key,
    this.zoomLevel,
    this.locationsFuture,
  }) : super(key: key);

  @override
  _LocationMapperState createState() => _LocationMapperState();
}

class _LocationMapperState extends State<LocationMapper> {
  static const String TAG = "LocationMapper";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<GoogleMapStateBase>();
  List<Location> locations = List();

  @override
  void initState() {
    super.initState();

    widget.locationsFuture.then((value) {
      setState(() {
        this.locations = value;
        print("Total Markers: ${locations.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (locations.isNotEmpty) {
      return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: GoogleMap(
                key: _key,
                initialZoom: 13,
                mapType: MapType.roadmap,
                interactive: true,
                onTap: (coord) => {},
                mobilePreferences: const MobileMapPreferences(
                  trafficEnabled: true,
                  zoomControlsEnabled: false,
                ),
                webPreferences: WebMapPreferences(
                  fullscreenControl: true,
                  zoomControl: true,
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: kIsWeb ? 60 : 16,
              bottom: 16,
              child: Row(
                children: <Widget>[
                  LayoutBuilder(
                    builder: (context, constraints) =>
                        constraints.maxWidth < 1000
                            ? Row(children: _buildClearButtons())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildClearButtons(),
                              ),
                  ),
                  Spacer(),
                  ..._buildAddButtons(),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text("Loading markers.."),
      );
    }
  }

  void _generateMarkers() async {
    if (locations != null && locations.isNotEmpty) {
      for (int i = 0; i < locations.length; i++) {
        final location = locations[i];
        print("Loading marker: $i [${location.getLatLng().toString()}]");
        var geo = GeoCoord(
            location.getLatLng().latitude, location.getLatLng().longitude);
        GoogleMap.of(_key)
            .moveCamera(geo, waitUntilReady: true, zoom: 14.0, animated: true);
        GoogleMap.of(_key).addMarkerRaw(geo, info: 'test info');
      }
    }
  }

  List<Widget> _buildClearButtons() => [
        const SizedBox(width: 16),
        RaisedButton.icon(
          color: Colors.red,
          textColor: Colors.white,
          icon: Icon(Icons.pin_drop),
          label: Text('CLEAR MARKERS'),
          onPressed: () {
            GoogleMap.of(_key).clearMarkers();
          },
        )
      ];

  List<Widget> _buildAddButtons() => [
        FloatingActionButton(
          child: Icon(Icons.pin_drop),
          onPressed: () {
            _generateMarkers();
          },
        )
      ];
}
