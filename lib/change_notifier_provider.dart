import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculationModel with ChangeNotifier {
  int _sum = 0;

  int get sum => _sum;

  set sum(int value) => _sum = value;

  void sumAB(int a, int b) {
    _sum = a + b;
    notifyListeners();
  }
}

class ChangeNotifierScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Notifier Screen"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => CalculationModel(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ContentCalculation(),
          ),
        ),
      ),
    );
  }
}

class ContentCalculation extends StatelessWidget {
  final TextEditingController _textEditingA = TextEditingController();
  final TextEditingController _textEditingB = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CalculationModel model = Provider.of<CalculationModel>(context);
    return Column(
      children: [
        TextField(
          controller: _textEditingA,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Nhập số A"),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: _textEditingB,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: "Nhập số B"),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Kết quả: ${model._sum}",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 20,
        ),
        ButtonTheme(
          minWidth: 200,
          child: RaisedButton(
            onPressed: () {
              int a = int.parse(_textEditingA.text.toString());
              int b = int.parse(_textEditingB.text.toString());
              context.read<CalculationModel>().sumAB(a, b);
              //model.sumAB(a, b);
            },
            child: Text("Tính AB"),
            textColor: Colors.white,
          ),
        )
      ],
    );
  }
}
