import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app_poc/cubit/app_cubits.dart';
import 'package:travel_app_poc/main.dart';
import 'package:travel_app_poc/widgets/app_text.dart';
import 'package:travel_app_poc/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    'img-slide1.jpg',
    'img-slide2.jpg',
    'img-slide3.jpg',
    'img-slide4.jpg',
    'img-slide5.jpg',
    'img-slide6.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/${images[index]}'),
                    fit: BoxFit.cover),
              ),
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 150, 20, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: 'Trips',
                            size: 45,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                          AppText(
                            text: 'Mountain',
                            size: 45,
                            color: Colors.white,
                            weight: FontWeight.w200,
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 250,
                            child: AppText(
                              text:
                                  'Mountain hike give you an incredible sense of freedom along with endurance test',
                              color: Colors.white,
                              size: 14,
                              weight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(height: 20),
                          ResponsiveButton(
                              height: 50,
                              text: 'Next',
                              color: Colors.lightBlue,
                              ),
                          SizedBox(height: 40),
                          Row(
                            children: List.generate(6, (indexDots) {
                              return Container(
                                margin: EdgeInsets.only(right: 6),
                                height: 8,
                                width: index == indexDots ? 25 : 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: index == indexDots
                                        ? Colors.lightBlue
                                        : Colors.white),
                              );
                            }),
                          )
                        ],
                      ),
                    ]),
              ),
            );
          }),
    );
  }
}
