import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inheritedwidget/pageView/page1.dart';
import 'package:inheritedwidget/pageView/page2.dart';
import 'package:inheritedwidget/pageView/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'drawing.dart';

class DetailsPage extends StatefulWidget {
  final String plantPic;
  final String name;
  final String description;
  final String rate;
  const DetailsPage(
      {Key? key,
      required this.plantPic,
      required this.name,
      required this.description,
      required this.rate})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              // Child 1: Actual Page
              PageView(
                // 4 pages -- Plant Description, 3 Test Pages
                scrollDirection: Axis.vertical,
                controller: _controller,
                children: [
                  // Child 1: Plant Desciption Page
                  Stack(
                    children: [
                      // Child 1: White Background
                      Container(
                        height: height,
                        width: width,
                        color: Colors.white,
                      ),
                      // Child 2: Green Drawing
                      SizedBox(
                        height: height / 1.5,
                        width: width,
                        child: CustomPaint(
                          painter: CurvePainter(height: height, width: width),
                        ),
                      ),
                      // Child 3: Plant Details
                      details(),
                      // Child 4: Row in bottom
                      Padding(
                        padding: EdgeInsets.only(top: height * .7),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  bottomInformationRow('assets/scale.png',
                                      "Height", "40cm - 50cm"),
                                  bottomInformationRow(
                                      'assets/thermo.png',
                                      "Temperature",
                                      "18" + "\u2103" + " to 25" + "\u2103"),
                                  bottomInformationRow('assets/pot.png', "Pot",
                                      "Self Watering Pot"),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Child 1: Test Page 1
                  Page1(),
                  // Child 2: Test Page 2
                  Page2(),
                  // Child 3: Test Page 3
                  Page3()
                ],
              ),
              // Child 2: The Vertical carousel Indicator
              Padding(
                padding: EdgeInsets.only(
                  top: height * .43,
                  left: width * .05,
                ),
                child: Transform.rotate(
                  angle: pi / 2,
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: Color.fromARGB(255, 100, 161, 73),
                        dotColor: Color.fromARGB(255, 151, 199, 97),
                        radius: 8,
                        expansionFactor: 2,
                        dotHeight: 8,
                        dotWidth: 8),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget details() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: width * .2, right: width * .2, top: height * .1),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 250,
          width: 250,
          alignment: Alignment.center,
          child: Image.network(
            widget.plantPic,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          widget.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 25),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.description,
          style: const TextStyle(
              color: Color.fromARGB(255, 185, 185, 185), fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$${widget.rate}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 22),
            ),
            const SizedBox(
              width: 40,
            ),
            const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_circle_outlined,
                ))
          ],
        )
      ]),
    );
  }

  Widget bottomInformationRow(String diagramPath, desc, quality) {
    return Column(
      children: [
        Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(diagramPath),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(desc,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                fontSize: 18)),
        SizedBox(
          height: 5,
        ),
        Text(quality,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white70,
                fontSize: 15)),
      ],
    );
  }
}
