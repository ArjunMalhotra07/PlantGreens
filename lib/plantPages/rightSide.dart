import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inheritedwidget/plantPages/details_Page.dart';

class GreenPlants extends StatelessWidget {
  List<String> assetImages = ['assets/plant1.png', 'assets/plant2.png'];
  List<String> namesOfPlant = ['Turf Pot Plant', 'Scandinavian Plant'];
  List<String> descriptionOfPlant = [
    'Big leaf plant in a turf pot for your home or office decor',
    'Low maintenance flower in a white ceramic pot'
  ];
  List<String> rateOfPlant = ['50.00', '20.00'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Right Container
    return Container(
      height: height,
      color: Colors.white,
      width: width * .75,
      child: Column(
        // 2 children -- 1. Green Plants Column.     2. ListView.Builder
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child 1. Green Plants Column.
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Green",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 185, 185, 185),
                      fontSize: 15),
                ),
                Text(
                  "Plants",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35),
                )
              ],
            ),
          ),
          // Child 2. ListView.builder
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return plantsListRightSide(
                      assetImages[index],
                      namesOfPlant[index],
                      descriptionOfPlant[index],
                      rateOfPlant[index],
                      context);
                }),
          ),
        ],
      ),
    );
  }

  Widget plantsListRightSide(
      String assetImage, name, description, rate, var context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    plantPic: assetImage,
                    name: name,
                    description: description,
                    rate: rate,
                  ),
                ),
              );
            },
            child: Image.asset(assetImage)),
        const SizedBox(
          height: 35,
        ),
        Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: const TextStyle(
              color: Color.fromARGB(255, 185, 185, 185), fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$$rate",
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
}

class IndoorPlants extends StatelessWidget {
  List<String> assetImages = ['assets/plant7.jpg', 'assets/plant4.jpg'];
  List<String> namesOfPlant = ['Turf Pot Plant', 'Scandinavian Plant'];
  List<String> descriptionOfPlant = [
    'Big leaf plant in a turf pot for your home or office decor',
    'Low maintenance flower in a white ceramic pot'
  ];
  List<String> rateOfPlant = ['50.00', '20.00'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Right Container
    return Container(
      height: height,
      color: Colors.white,
      width: width * .75,
      child: Column(
        // 2 children -- 1. Green Plants Column.     2. ListView.Builder
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child 1. Green Plants Column.
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Green",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 185, 185, 185),
                      fontSize: 15),
                ),
                Text(
                  "Plants",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35),
                )
              ],
            ),
          ),
          // Child 2. ListView.builder
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return plantsListRightSide(
                      assetImages[index],
                      namesOfPlant[index],
                      descriptionOfPlant[index],
                      rateOfPlant[index],
                      context);
                }),
          ),
        ],
      ),
    );
  }

  Widget plantsListRightSide(
      String assetImage, name, description, rate, var context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    plantPic: assetImage,
                    name: name,
                    description: description,
                    rate: rate,
                  ),
                ),
              );
            },
            child: Image.asset(assetImage)),
        const SizedBox(
          height: 35,
        ),
        Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: const TextStyle(
              color: Color.fromARGB(255, 185, 185, 185), fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$$rate",
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
}

class ShapeClose extends StatelessWidget {
  List<String> assetImages = ['assets/plant5.jpg', 'assets/plant6.jpg'];
  List<String> namesOfPlant = ['Turf Pot Plant', 'Scandinavian Plant'];
  List<String> descriptionOfPlant = [
    'Big leaf plant in a turf pot for your home or office decor',
    'Low maintenance flower in a white ceramic pot'
  ];
  List<String> rateOfPlant = ['50.00', '20.00'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Right Container
    return Container(
      height: height,
      color: Colors.white,
      width: width * .75,
      child: Column(
        // 2 children -- 1. Green Plants Column.     2. ListView.Builder
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child 1. Green Plants Column.
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Green",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 185, 185, 185),
                      fontSize: 15),
                ),
                Text(
                  "Plants",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 35),
                )
              ],
            ),
          ),
          // Child 2. ListView.builder
          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return plantsListRightSide(
                      assetImages[index],
                      namesOfPlant[index],
                      descriptionOfPlant[index],
                      rateOfPlant[index],
                      context);
                }),
          ),
        ],
      ),
    );
  }

  Widget plantsListRightSide(
      String assetImage, name, description, rate, var context) {
    return Padding(
      padding: const EdgeInsets.all(45.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    plantPic: assetImage,
                    name: name,
                    description: description,
                    rate: rate,
                  ),
                ),
              );
            },
            child: Image.asset(assetImage)),
        const SizedBox(
          height: 35,
        ),
        Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          description,
          style: const TextStyle(
              color: Color.fromARGB(255, 185, 185, 185), fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$$rate",
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
}
