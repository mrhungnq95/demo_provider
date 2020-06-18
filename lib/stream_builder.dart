import 'package:flutter/material.dart';

class StreamBuilderScreen extends StatefulWidget {
  @override
  _StreamBuilderScreenState createState() => _StreamBuilderScreenState();
}

class _StreamBuilderScreenState extends State<StreamBuilderScreen> {
  Stream<String> downloadFuokFuok() {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 5), () {
      return "Downloaded: FuokFuok here!";
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder Screen"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: StreamBuilder(
            initialData: "Init...",
            builder: (buildContext, snapShot) {
              print("${snapShot.connectionState.toString()}");

              if (snapShot.hasData) {
                return Text(snapShot.data);
              } else {
                return Text("No Data");
              }
            },
            stream: downloadFuokFuok(),
          )),
    );
  }
}
