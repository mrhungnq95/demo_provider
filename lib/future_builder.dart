import 'package:flutter/material.dart';

class FeatureBuilderScreen extends StatefulWidget {
  @override
  _FeatureBuilderScreenState createState() => _FeatureBuilderScreenState();
}

class _FeatureBuilderScreenState extends State<FeatureBuilderScreen> {
  Future<String> downloadFuokFuok() async {
    return await Future.delayed(Duration(seconds: 5), () {
      return "Downloaded: FuokFuok here!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feature Builder Screen"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: FutureBuilder(
            initialData: "Init...",
            builder: (buildContext, snapShot) {
              print("${snapShot.connectionState.toString()}");

              if (snapShot.hasData) {
                return Text(snapShot.data);
              } else {
                return Text("No Data");
              }
            },
            future: downloadFuokFuok(),
          )),
    );
  }
}
