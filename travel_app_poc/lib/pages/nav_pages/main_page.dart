import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app_poc/pages/nav_pages/bar_item_page.dart';
import 'package:travel_app_poc/pages/home_page.dart';
import 'package:travel_app_poc/pages/nav_pages/my_page.dart';
import 'package:travel_app_poc/pages/nav_pages/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = const [HomePage(), BarItemPage(), SerachPage(), MyPage()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), label: 'Home', tooltip: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_sharp),
                label: 'Bar',
                tooltip: 'Bar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: 'Search', tooltip: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'My', tooltip: 'My')
          ]),
    );
  }
}
