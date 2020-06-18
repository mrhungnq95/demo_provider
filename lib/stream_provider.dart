import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamProviderScreen extends StatefulWidget {
  @override
  _StreamProviderScreenState createState() => _StreamProviderScreenState();
}

class _StreamProviderScreenState extends State<StreamProviderScreen> {
  Stream<String> downloadFuokFuok() {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 5), () {
      return "Downloaded: FuokFuok here!";
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Provider Screen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: StreamProvider(
          create: (_) => downloadFuokFuok(),
          initialData: "Downloading fuokfuok.vn by Stream Provider",
          child: Consumer<String>(
            builder: (context, value, child) {
              return Text(value);
            },
          ),
        ),
      ),
    );
  }
}
