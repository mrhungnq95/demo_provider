import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Info {
  String _welcomeTitle = "Welcome FuokFuok!";
  String _description =
      "A wrapper around InheritedWidget to make them easier to use and more reusable.";

  String get getDescription => _description;

  set setDescription(String value) => _description = value;

  String get getWelcomeTitle => _welcomeTitle;

  set setWelcomeTitle(String welcomeTitle) => this._welcomeTitle = welcomeTitle;
}

class BasicProviderScreen extends StatefulWidget {
  @override
  _BasicProviderScreenState createState() => _BasicProviderScreenState();
}

class _BasicProviderScreenState extends State<BasicProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Basic Provider"),
        ),
        body: Provider(
          create: (_) {
            return Info();
          },
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [WelcomeView(), MoreInfoView(), MoreInfoView2()],
            ),
          ),
        ));
  }
}

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Info>(
      builder: (context, info, child) {
        return Text(
          info.getWelcomeTitle,
          style: Theme.of(context).textTheme.title,
        );
      },
    );
  }
}

class MoreInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Info info = Provider.of<Info>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        info.getDescription,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class MoreInfoView2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        context.watch<Info>().getDescription,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
