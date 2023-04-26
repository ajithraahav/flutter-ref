import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splash_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => HomeScreen())))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 150,
              ),
              SizedBox(
                height: 50,
              ),
              const SpinKitChasingDots(
                color: Colors.blue,
                size: 50.0,
                duration: Duration(milliseconds: 1200),
              )
            ])));
  }
}
