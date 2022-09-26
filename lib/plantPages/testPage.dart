import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inheritedwidget/plantPages/details_Page.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key, this.selectedIndex}) : super(key: key);
  var selectedIndex;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    final CollectionReference _collectionRef1 =
        FirebaseFirestore.instance.collection('IndoorPlants');

    final CollectionReference _collectionRef0 =
        FirebaseFirestore.instance.collection('plantGreens');

    final CollectionReference _collectionRef2 =
        FirebaseFirestore.instance.collection('collection3');
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
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
            )),
        body: StreamBuilder<QuerySnapshot>(
          stream: widget.selectedIndex == 0
              ? _collectionRef0.snapshots()
              : widget.selectedIndex == 1
                  ? _collectionRef1.snapshots()
                  : _collectionRef2.snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (name == "") {
                        return Container();
                      }
                      if (data['plant_name']
                          .toString()
                          .toLowerCase()
                          .contains(name.toLowerCase())) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                  plantPic: data['pictureofPlant'],
                                  description: data['description'],
                                  rate: data['price'].toString(),
                                  name: data['plant_name'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              data['plant_name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['pictureofPlant']),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    });
          },
        ));
  }
}
