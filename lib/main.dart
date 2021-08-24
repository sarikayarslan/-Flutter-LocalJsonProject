import 'package:flutter/material.dart';
import 'dart:convert';
import 'item.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List item;
  _MyAppState createState() => _MyAppState();

  var parentId = 2;
  String categoryName ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            height: 150,
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/jsonArray.json"),
              builder: (context, asyncSnapshot) {
                item = jsonDecode(asyncSnapshot.data.toString());

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (item[index]['parentId'] == null) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              parentId = item[index]['id'];
                              print(index);
                              categoryName = item[index]['name'];
                            });
                          },
                          child: HorizontalImage(
                              item[index]['picture'].toString()));
                    } else {
                      return Container(color: Colors.white // This is optional
                          );
                    }
                  },
                  itemCount: item == null ? 0 : item.length,
                );
              },
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left:25, bottom: 20),
                child: Text(

                  categoryName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                      fontFamily: 'Open Sans'),
                ),
              )),
          //Text(item[indexGetter]['name'].toString()),
          Container(
            height: 430,
            child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/jsonArray.json"),
              builder: (context, asyncSnapshot) {
                item = jsonDecode(asyncSnapshot.data.toString());

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    if (item[index]['parentId'] == parentId) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 3,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: HorizontalImage(
                                    item[index]['picture'].toString()),
                              ),
                              Text(
                                item[index]['name'].toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Open Sans'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(color: Colors.white // This is optional
                          );
                    }
                  },
                  itemCount: item == null ? 0 : item.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget HorizontalImage(String imageUrl) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
                child: Image.network(
              imageUrl,
            )))),
  );
}

Widget verticalList() {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
    child: Container(
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        elevation: 3,
        child: ListTile(
          leading: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/pill.png',
                  width: 40,
                  height: 40,
                ),
              )),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Merhaba",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: 'Open Sans'),
          ),
          subtitle: Text(
            "Deneme",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: 'Open Sans'),
          ),
          onTap: () {},
        ),
      ),
    ),
  );
}
