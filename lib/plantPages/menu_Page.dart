import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/login_page.dart';
import 'details_Page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<String> assetImages = [
    'assets/plant7.jpg',
    'assets/plant2.png',
    'assets/plant4.jpg'
  ];
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('IndoorPlants');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    print(allData[0]);
    print(allData[1]);
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
        body: StreamBuilder(
            stream: _collectionRef.snapshots(),
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
                          child: ListView(
                            // reverse: true,
                            children:
                                snapshot.data.docs.map<Widget>((document) {
                              print("rate -> ${document['price']}");
                              print(
                                  "description-- > ${document['description']}");
                              print("name -- > ${document['plant_name']}");
                              print("****");
                              return plantsListRightSide(
                                  assetImages[1],
                                  document['plant_name'],
                                  document['description'],
                                  document['price'].toString(),
                                  context);
                            }).toList(),
                          ),
                        ),
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
            }));
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
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => PageIndicator()),
            //   );
            // },
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
