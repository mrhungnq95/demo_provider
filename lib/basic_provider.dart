import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasicProviderScreen extends StatefulWidget {
  @override
  _BasicProviderScreenState createState() => _BasicProviderScreenState();
}

class Info {
  String _welcomeTitle = "Welcome FuokFuok!";

  String get getWelcomeTitle => _welcomeTitle;

  set setWelcomeTitle(String welcomeTitle) => this._welcomeTitle = welcomeTitle;
}

class _BasicProviderScreenState extends State<BasicProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        return Info();
      },
      child: Center(
        child: Consumer<Info>(
          builder: (context, info, child) {
            return Text(info.getWelcomeTitle);
          },
        ),
      ),
    );
  }
}
