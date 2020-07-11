import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'location_model.dart';

Future<String> _loadAsset(BuildContext context) async {
  return await DefaultAssetBundle.of(context)
      .loadString('assets/testCoordinates');
}

Future<List<Location>> getLocationsList(BuildContext context) {
  Completer c = Completer<List<Location>>();
  List<Location> locationsList = List();
  _loadAsset(context).then((value) {
    //print(data);
    LineSplitter.split(value).forEach((line) {
      List<String> data = line.split(";");
      locationsList.add(Location(lat: data.first, lon: data.last));
    });
    c.complete(locationsList);
  });
  return c.future;
}
