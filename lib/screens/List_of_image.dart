import 'package:carouse_slider/screens/globals.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: vertical(),
    ),
  );
}

class vertical extends StatefulWidget {
  @override
  State<vertical> createState() => _verticalState();
}

class _verticalState extends State<vertical> {
  final List<String> car = [
    'Nature',
    'Cars',
    'Dogs',
  ];
  int _currentIndex = 0;
  int currentPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Slider",
        ),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChipList(
                listOfChipNames: car,
                activeBgColorList: [Colors.greenAccent],
                inactiveBgColorList: [Colors.cyan],
                activeTextColorList: [Colors.black87],
                inactiveTextColorList: [Colors.black],
                activeBorderColorList: [Colors.black],
                listOfChipIndicesCurrentlySeclected: [_currentIndex],
                extraOnToggle: (val) {
                  _currentIndex = val;
                  setState(() {
                    Images = allList[val];
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              initialPage: currentPage,
              onPageChanged: (val, _) {
                setState(() {
                  currentPage = val;
                });
                print(currentPage);
              },
              scrollDirection: Axis.horizontal,
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: false,
              autoPlayCurve: Curves.easeInOutBack,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.7,
            ),
            items: Images.map(
                  (e) => Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("${e['image']}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ).toList(),
          ),
          SizedBox(height: 10),
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Images.map((e) {
                int i = Images.indexOf(e);
                return GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(
                      i,
                      duration: Duration(milliseconds: 800),
                    );
                  },
                  child: CircleAvatar(
                      radius: 5,
                      backgroundColor:
                      (currentPage == i) ? Colors.black87 : Colors.white60),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
