import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import './basic_widgets.dart';
// import './home_page_map.dart';
import './fetch_current_location.dart';

class LiveLocationButton extends StatefulWidget {
  LiveLocationButton({
    Key? super.key,
    required this.liveUpdate,
  });

  bool liveUpdate;

  @override
  State<LiveLocationButton> createState() => _LiveLocationButtonState();
}

Position? position;

class _LiveLocationButtonState extends State<LiveLocationButton> {
  Widget mapWidget1 = FlutterMap(
    options: MapOptions(
      center: LatLng(
        43,
        -75,
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
  Widget? mapWidget;

  LocationData? _currentLocation;
  late final MapController _mapController;

  bool _liveUpdate = false;
  bool _permission = false;

  String? _serviceError = '';

  final Location _locationService = Location();
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    initLocationService();
    mapWidget = mapWidget1;
  }

  void initLocationService() async {
    await _locationService.changeSettings(
      // accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          _locationService.onLocationChanged.listen(
            (LocationData result) async {
              if (mounted) {
                setState(
                  () {
                    _currentLocation = result;
                    if (_liveUpdate) {
                      _mapController.move(
                        LatLng(
                          _currentLocation!.latitude!,
                          _currentLocation!.longitude!,
                        ),
                        _mapController.zoom,
                      );
                    }
                  },
                );
              }
            },
          );
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(
        43,
        -75,
      );
    }

    final markers = <Marker>[
      Marker(
        width: 40,
        height: 40,
        point: currentLatLng,
        builder: (context) => const Icon(
          Icons.location_on,
        ),
      ),
    ];

    return Scaffold(
      appBar: homePageAppBar,
      body: mapWidget!,
      // body: Column(
      //   children: [
      //     Flexible(
      //       child: FlutterMap(
      //         mapController: _mapController,
      //         options: MapOptions(
      //           center: LatLng(
      //             currentLatLng.latitude,
      //             currentLatLng.longitude,
      //           ),
      //           zoom: 5,
      //         ),
      //         children: [
      //           TileLayer(
      //             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      //             userAgentPackageName: 'com.example.app',
      //           ),
      //           MarkerLayer(
      //             markers: markers,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(
      //       () {
      //         if (count == 1) {
      //           initLocationService();
      //           count++;
      //         }
      //         if (!widget.liveUpdate) {
      //           widget.liveUpdate = !widget.liveUpdate;
      //         }
      //       },
      //     );
      //   },
      //   child: widget.liveUpdate
      //       ? const Icon(
      //           Icons.my_location,
      //         )
      //       : const Icon(
      //           Icons.location_searching,
      //         ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() async {
            await getCurrentLoctaion();
            mapWidget = mapWidget2!;
          });
        },
      ),
    );

    // return Builder(
    //   builder: (BuildContext context) {
    //     return FloatingActionButton(
    //       onPressed: () {
    //         setState(
    //           () {
    //             if (!widget.liveUpdate) {
    //               widget.liveUpdate = !widget.liveUpdate;
    //             }
    //           },
    //         );
    //       },
    //       child: widget.liveUpdate
    //           ? const Icon(
    //               Icons.my_location,
    //             )
    //           : const Icon(
    //               Icons.location_searching,
    //             ),
    //     );
    //   },
    // );
  }
}

Widget? mapWidget2;
getCurrentLoctaion() async {
  position = await determinePosition();
  mapWidget2 = FlutterMap(
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
}
