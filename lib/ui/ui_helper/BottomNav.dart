import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: SizedBox(
        height: 136,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff704F38), borderRadius: BorderRadius.circular(32)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        icon: const Icon(Icons.home)),
                    IconButton(
                         onPressed: () {
                          controller.animateToPage(1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        icon: const Icon(Icons.home)),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 20,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                       onPressed: () {
                          controller.animateToPage(2,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        icon: Icon(Icons.home)),
                    IconButton(
                       onPressed: () {
                          controller.animateToPage(3,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        icon: Icon(Icons.home)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
