import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'current_location.dart' as CurrentLocation;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MapController _mapController;

  double ping_icon = 30;
  LatLng point = LatLng(11.0007, 77.0296);
  Position? position;

  Icon fabIcon = Icon(
    Icons.gps_not_fixed,
    size: 25,
  );
  Future<Position> getCurrentLocation() async {
    Position getPosition = await CurrentLocation.determinePosition();
    return getPosition;
  }

  late final StreamSubscription<MapEvent> mapEventSubscription;
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    mapEventSubscription = _mapController.mapEventStream.listen(onMapEvent);
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is MapEventMove && mapEvent.targetCenter != position) {
      setState(() {
        fabIcon = Icon(
          Icons.gps_not_fixed,
          size: 25,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];
    marker = [
      Marker(
        width: 100.0,
        height: 100.0,
        point: point,
        builder: (ctx) => IconButton(
          //Icon as a button - remove const from center
          onPressed: () {
            setState(() {
              ping_icon = 50;
            });
          },
          icon: const Icon(Icons.location_on_sharp),
          color: Colors.blue,
          iconSize: ping_icon,
        ),
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on),
                hintText: 'Search for lcoation',
              ),
            ),
          ),
          Flexible(
              child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
                onTap: (tapPosition, tap_latlng) {
                  setState(() {
                    point = tap_latlng;
                    ping_icon = 30;
                  });
                },
                center: position != null
                    ? LatLng(position!.latitude, position!.longitude)
                    : LatLng(11.0007, 77.0296),
                zoom: 8),
            children: [
              TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
              MarkerLayer(markers: marker),
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var currentPosition = await getCurrentLocation();
          setState(() {
            position = currentPosition;
            point = LatLng(currentPosition.latitude, currentPosition.longitude);
            fabIcon = const Icon(
              Icons.gps_fixed,
              size: 25,
            );
          });
          _mapController.move(point, 18);
        },
        child: fabIcon,
        backgroundColor: Colors.black,
      ),
    );
  }
}
