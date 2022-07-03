import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SvgPicture.asset(
            "assets/chromecast.svg",
            color: Colors.white,
            width: 25.0,
            height: 25.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SvgPicture.asset(
              "assets/notification.svg",
              color: Colors.white,
              width: 20.0,
              height: 20.0,
            ),
          ),
          SvgPicture.asset(
            "assets/search.svg",
            color: Colors.white,
            width: 20.0,
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 15.0),
            child: const CircleAvatar(
              radius: 13,
              backgroundImage: AssetImage('assets/pfp.jpg'),
            ),
          ),
        ],
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/logo.svg",
              width: 30.0,
              height: 30.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Text("Youtube"),
          ],
        ),
      ),
      body: FutureBuilder(
          future:
              DefaultAssetBundle.of(context).loadString('dataset/dataset.json'),
          builder: (context, snapshot) {
            var new_data = json.decode(snapshot.data.toString());
            return ListView.builder(
                // itemCount: new_data == null ? 0 : new_data.length,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[900],
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
