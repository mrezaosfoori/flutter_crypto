import 'package:demo/ui/Homepage.dart';
import "package:flutter/material.dart";
import 'package:demo/ui/ui_helper/ThemeSwitcher.dart';
import 'package:demo/ui/ui_helper/BottomNav.dart';
import 'Homepage.dart';
import 'MarketViewPage.dart';
import 'Profile.dart';
//import 'WatchListPage.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeSwitcher()],
        title: Text('CryptoBrown ', style: textTheme.titleLarge),
        backgroundColor: const Color(0xffDC143C),
      ),
      bottomNavigationBar: BottomNav(controller:_myController),
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(50),
      //     color: const Color.fromARGB(255, 172, 13, 13),
      //   ),
      //   child: IconButton(
      //     onPressed: () {},
      //     icon: Icon(Icons.abc_sharp),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _myController,
        children: [Homepage(), MarketViewPage(), Profile()],
      ),
    );
  }
}
