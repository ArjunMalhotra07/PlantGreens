import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inheritedwidget/plantPages/testPage.dart';
import '../auth/login_page.dart';
import 'details_Page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final CollectionReference _collectionRef1 =
      FirebaseFirestore.instance.collection('IndoorPlants');

  final CollectionReference _collectionRef0 =
      FirebaseFirestore.instance.collection('plantGreens');

  final CollectionReference _collectionRef2 =
      FirebaseFirestore.instance.collection('collection3');

  int selectedIndex = 0;
  bool showSearchTextField = false;
  String name = "";

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
            title: Card(
              child: TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
            leadingWidth: MediaQuery.of(context).size.width * .25,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print("Clicked Search");
                    print(showSearchTextField);
                    showSearchTextField = !showSearchTextField;
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => TestPage(
                    //       selectedIndex: selectedIndex,
                    //     ),
                    //   ),
                    // );
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
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
          body: body(height, width)),
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
          padding: const EdgeInsets.only(bottom: 50.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            child: const Icon(
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

  Widget body(var height, width) {
    return StreamBuilder(
        stream: selectedIndex == 0
            ? _collectionRef0.snapshots()
            : selectedIndex == 1
                ? _collectionRef1.snapshots()
                : _collectionRef2.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            print("Inside");
            return Row(children: [
              left(),
              Container(
                height: height,
                color: Colors.white,
                width: width * .75,
                child: Column(
                  // 2 children -- 1. Green Plants Column.     2. ListView.Builder
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Child 1. Green Plants Column.
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0, top: 50),
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
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            print("rate -> ${data['price']}");
                            print("description-- > ${data['description']}");
                            print("name -- > ${data['plant_name']}");
                            print("name -- > ${data['pictureofPlant']}");
                            print("****");
                            // return plantsListRightSide(
                            //     data['pictureofPlant'],
                            //     data['plant_name'],
                            //     data['description'],
                            //     data['price'],
                            //     context);

                            if (data['plant_name']
                                .toString()
                                .toLowerCase()
                                .contains(name.toLowerCase())) {
                              return plantsListRightSide(
                                  data['pictureofPlant'],
                                  data['plant_name'],
                                  data['description'],
                                  data['price'],
                                  context);
                              ;
                            } else {
                              return Container();
                            }
                          }),
                    )
                  ],
                ),
              ),
            ]);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
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
                    rate: rate.toString(),
                  ),
                ),
              );
            },
            child: Image.network(assetImage)),
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
