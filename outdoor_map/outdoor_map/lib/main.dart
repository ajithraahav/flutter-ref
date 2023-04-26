import 'package:flutter/material.dart';

import 'widgets/live_location.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final bool _liveUpdate = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OutDoor Map',
      debugShowCheckedModeBanner: false,
      home: LiveLocationButton(
        liveUpdate: _liveUpdate,
      ),
    );
  }
}
