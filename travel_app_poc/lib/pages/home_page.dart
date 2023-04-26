import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app_poc/cubit/app_cubit_states.dart';
import 'package:travel_app_poc/cubit/app_cubits.dart';
import 'package:travel_app_poc/widgets/app_text.dart';
import 'package:travel_app_poc/widgets/dot_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map exploreImages = {
    'hiking1.png': 'Hiking',
    'snowskate.png': 'Snow Skating',
    'snorking.png': 'Snorking',
    'kayaking.png': 'Kayaking',
    'balloning.png': 'Balloning',
  };
  List<Color> imageColor = [
    Colors.green,
    Colors.lightBlue.shade400,
    Colors.amber.shade400,
    Colors.blueAccent,
    Colors.deepPurple.shade300,
  ];
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
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
        body: BlocBuilder<AppCubits, CubitStates>(builder: ((context, state) {
      if (state is LoadedState) {
        var info = state.places;
        return CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
          SliverAppBar.large(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            title: Text("Discover"),
            actions: [
              Container(
                width: 40,
                height: 20,
                child: SvgPicture.asset('assets/images/avatar.svg',
                    fit: BoxFit.scaleDown),
                margin: EdgeInsets.only(right: 15),
                // width: 50,
                // height: 50,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.grey.withOpacity(0.5)),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: EdgeInsets.only(top: 70, left: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Icon(
                //         Icons.menu,
                //         size: 30,
                //         color: Colors.black,
                //       ),
                //       Container(
                //         margin: EdgeInsets.only(right: 20),
                //         width: 50,
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             color: Colors.grey.withOpacity(0.5)),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 28,
                // ),
                // Container(
                //     margin: EdgeInsets.only(left: 20),
                //     child: AppText(
                //       text: 'Discover',
                //       color: Colors.black,
                //       weight: FontWeight.bold,
                //     )),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                        labelPadding: EdgeInsets.only(left: 20, right: 20),
                        controller: _tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        indicator:
                            DotIndicator(color: Colors.blueAccent, radius: 3),
                        tabs: [
                          Tab(
                            text: 'Places',
                          ),
                          Tab(
                            text: 'Inspiration',
                          ),
                          Tab(
                            text: 'Emotions',
                          ),
                        ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(controller: _tabController, children: [
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: info.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () =>  BlocProvider.of<AppCubits>(context).detailPage(info[index]),
                          child: Container(
                            margin: EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: AssetImage(info[index].img),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      },
                    ),
                    Text('There'),
                    Text('Bye'),
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'Explore more',
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                      AppText(
                        text: 'See all',
                        color: Colors.blue.shade300,
                        size: 14,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 100,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: exploreImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 25),
                          child: Column(
                            children: [
                              Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: imageColor[index].withOpacity(0.2),
                                  ),
                                  child: Image.asset(
                                    'assets/images/' +
                                        exploreImages.keys.elementAt(index),
                                    scale: 0.04,
                                    color: imageColor[index],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: AppText(
                                  text: exploreImages.values.elementAt(index),
                                  size: 12,
                                  weight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ]);
      } else {
        return Container();
      }
    })));
  }
}
