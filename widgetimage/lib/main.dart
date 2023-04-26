import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ImageSnap());
  }
}

class ImageSnap extends StatefulWidget {
  const ImageSnap({super.key});

  @override
  State<ImageSnap> createState() => _ImageSnapState();
}

class _ImageSnapState extends State<ImageSnap> {
  final key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: key,
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                height: 200,
                width: 400,
                child: const Center(
                    child: Text(
                  "Hello world!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ))),
                ElevatedButton(onPressed: () => capturePng(key), child: Text('dddddd'))
          ],
        ),
      ),
    );
  }
}

Future<String> capturePng(GlobalKey rootkey) async {
  final boundary =
      rootkey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

  final image = await boundary?.toImage();
  final byteData = await image?.toByteData(format: ImageByteFormat.png);
  final imageBytes = byteData?.buffer.asUint8List();

  final imageEncoded = base64.encode(imageBytes as List<int>);
  print(imageEncoded);
  return imageEncoded;
}
