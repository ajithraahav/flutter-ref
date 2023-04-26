import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app_poc/cubit/app_cubi_logics.dart';
import 'package:travel_app_poc/cubit/app_cubits.dart';
import 'package:travel_app_poc/pages/detail_page.dart';
import 'package:travel_app_poc/pages/nav_pages/main_page.dart';
import 'package:travel_app_poc/pages/services/data_services.dart';
import 'package:travel_app_poc/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AppCubits>(
        create: (context) => AppCubits(
          data: DataServices(),
        ),
        child: AppCubitLogics(),
        ),
    );
  }
}
 