import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados";

  void _resetFildes() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
    });
  }

  String _getImcResult(double imc) {
    String result;
    if (imc < 18.6) {
      result = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      result = "Peso Ideal (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      result = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      result = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
    } else if (imc <= 34.9 && imc < 39.9) {
      result = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
    } else if (imc >= 40) {
      result = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
    }
    return result;
  }

  void _caculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      _infoText = _getImcResult(imc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFildes)
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120, color: Colors.green),
              TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: weightController),
              TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (Cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: heightController),
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: _caculate,
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ));
  }
}
