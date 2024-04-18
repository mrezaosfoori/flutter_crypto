import "package:flutter/material.dart";

class HomePageView extends StatefulWidget {
  var controller;
   HomePageView({super.key, required this.controller});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    var images = [
      'images/a1.png',
      'images/a2.png',
      'images/a3.png',
      'images/a4.png',
    ];
    return PageView(
      allowImplicitScrolling: true,
       controller: widget.controller,
      children: [
        myPages(images[0]),
        myPages(images[1]),
        myPages(images[2]),
        myPages(images[3]),
      ],
    );
  }

  Widget myPages(String image) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Image(
          image: AssetImage(image),
          fit: BoxFit.fill,
        ));
  }
}
