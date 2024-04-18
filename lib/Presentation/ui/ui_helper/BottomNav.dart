
import 'package:flutter/material.dart';


class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var primaryColor = Theme.of(context).primaryColor;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: const Color(0xff704F38),
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 -20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (){
                        controller.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      icon: const Icon(Icons.home)),
                  IconButton(onPressed: (){
                    controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, icon: const Icon(Icons.bar_chart)),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    controller.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }, icon: const Icon(Icons.person)),
                  IconButton(
                      onPressed: (){
                        controller.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      },
                      icon: const Icon(Icons.bookmark)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
