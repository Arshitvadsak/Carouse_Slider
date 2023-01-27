import 'package:carouse_slider/screens/globals.dart';
import 'package:carouse_slider/screens/List_of_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  CarouselController carouselController = CarouselController();
  bool Change = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Slider",
            ),
            Spacer(),
            Switch(
              // This bool value toggles the switch.
              value: Change,
              activeColor: Colors.red,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  Change = value;
                });
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.green[300],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    initialPage: currentPage,
                    onPageChanged: (val, _) {
                      setState(() {
                        currentPage = val;
                      });
                      print(currentPage);
                    },
                    scrollDirection:
                        (Change == false) ? Axis.horizontal : Axis.vertical,
                    height: 250,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    autoPlayCurve: Curves.easeInOutBack,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.7,
                  ),
                  items: Images.map(
                    (e) => Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            "${e['image']}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ),
              (Change == true)
                  ? Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
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
                                    backgroundColor: (currentPage == i)
                                        ? Colors.black87
                                        : Colors.white60),
                              );
                            }).toList(),
                          ),
                        ),
                      ))
                  : Container(),
            ],
          ),
          SizedBox(height: 10),
          (Change == false)
              ? Container(
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
                            backgroundColor: (currentPage == i)
                                ? Colors.black87
                                : Colors.white60),
                      );
                    }).toList(),
                  ),
                )
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => vertical(),
            ),
          );
        },
        child: Text("Next"),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
