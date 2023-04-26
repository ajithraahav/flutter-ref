import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app_poc/cubit/app_cubit_states.dart';
import 'package:travel_app_poc/cubit/app_cubits.dart';
import 'package:travel_app_poc/widgets/app_buttons.dart';
import 'package:travel_app_poc/widgets/app_text.dart';
import 'package:travel_app_poc/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          child: Stack(children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(detail.place.img),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                left: 20,
                top: 50,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AppCubits>(context).goHome();
                      },
                      icon: Icon(Icons.menu),
                      color: Colors.white,
                    )
                  ],
                )),
            Positioned(
                top: 270,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            
                            child: AppText(
                              text: detail.place.name,
                              color: Colors.black54,
                              weight: FontWeight.w300,
                            ),
                          ),
                          AppText(
                            text: '\u20B9 ${detail.place.price}',
                            color: Colors.blue.shade700,
                            weight: FontWeight.w500,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          AppText(
                            text: detail.place.location,
                            color: Colors.blue.shade700,
                            size: 14,
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < detail.place.stars
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          AppText(
                            text: '${detail.place.stars}',
                            color: Colors.black54,
                            size: 14,
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      AppText(
                        text: 'People',
                        size: 20,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      AppText(
                        text: 'Number of people in your group',
                        color: Colors.grey,
                        size: 14,
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: AppButtons(
                                size: 50,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: selectedIndex == index
                                    ? Colors.black
                                    : Colors.purple.shade50.withOpacity(0.7),
                                borderColor: selectedIndex == index
                                    ? Colors.black
                                    : Colors.purple.shade50.withOpacity(0.7),
                                text: (index + 1).toString(),
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 25),
                      AppText(
                        text: 'Description',
                        size: 20,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${detail.place.description}',
                        style: TextStyle(
                            color: Colors.grey, fontSize: 14, height: 1.45),
                      ),
                    ],
                  ),
                )),
            Positioned(
                left: 20,
                bottom: 20,
                right: 20,
                child: Row(
                  children: [
                    AppButtons(
                      size: 60,
                      color: Colors.blue,
                      backgroundColor: Colors.white,
                      borderColor: Colors.blue,
                      isIcon: true,
                      icon: Icons.favorite_border,
                    ),
                    SizedBox(width: 20),
                    ResponsiveButton(
                      height: 60,
                      text: 'Book Trip Now',
                      isResponsive: true,
                    )
                  ],
                ))
          ]),
        ),
      );
    });
  }
}
