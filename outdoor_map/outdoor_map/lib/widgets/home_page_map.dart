import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import './fetch_current_location.dart';

Position? position;

Widget mapWidget = FlutterMap(
  options: MapOptions(
    //   center: LatLng(
    //     43,
    //     -75,
    //   ),
    center: LatLng(
      position!.latitude!,
      position!.longitude!,
    ),
    zoom: 8,
  ),
  children: [
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.app',
    ),
  ],
);

getCurrentLoctaion() async {
  position = await determinePosition();
}
