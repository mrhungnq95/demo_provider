import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeatureProviderScreen extends StatefulWidget {
  @override
  _FeatureProviderScreenState createState() => _FeatureProviderScreenState();
}

class _FeatureProviderScreenState extends State<FeatureProviderScreen> {
  Future<String> downloadFuokFuok() async {
    return await Future.delayed(Duration(seconds: 5), () {
      return "Downloaded: FuokFuok here!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feature Provider Screen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: FutureProvider(
          create: (_) => downloadFuokFuok(),
          initialData: "Downloading fuokfuok.vn",
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
