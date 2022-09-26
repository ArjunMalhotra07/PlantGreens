import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inheritedwidget/pageView/newPage.dart';
import 'package:inheritedwidget/plantPages/rightSide.dart';
import '../auth/login_page.dart';
import 'details_Page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _controller = PageController();

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * .25,
        actions: const [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
        leading: Container(
          width: MediaQuery.of(context).size.width * .35,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
            color: Color.fromARGB(255, 87, 141, 72),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Image.asset('assets/menu.png'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Row(children: [
            left(),
            selectedIndex == 0
                ? GreenPlants()
                : selectedIndex == 1
                    ? IndoorPlants()
                    : ShapeClose()
            // GreenPlants()
          ]),
        ],
      ),
    );
  }

  Widget left() {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 87, 141, 72),
      ),
      height: height,
      width: width * .25,
      child: Column(children: [
        SizedBox(
          height: height * .1,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 0;
                print(selectedIndex);
              });
            },
            child: leftContainerText('Green Plants')),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 1;
                print(selectedIndex);
              });
            },
            child: leftContainerText('Indoor Plant')),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 2;
                print(selectedIndex);
              });
            },
            child: leftContainerText('Shape close')),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
            onTap: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => Navigator.pushReplacement<void, void>(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      ));
            },
            child: leftContainerText('Sign Out')),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 50.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageIndicator()),
              );
            },
            child: Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),
        )
      ]),
    );
  }

  Widget leftContainerText(String incomingText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Transform.rotate(
        angle: -pi / 2,
        child: Container(
          child: Text(
            incomingText,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
