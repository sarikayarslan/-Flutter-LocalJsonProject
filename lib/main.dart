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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Json Deneme"),
      ),
      body: Column(
        children: [
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
                      return HorizontalImage(item[index]['picture'].toString());
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
