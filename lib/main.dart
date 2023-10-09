import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String infoText = 'Informe seus dados!';

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados!";
      formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(
      () {
        double weight = double.parse(weightController.text);
        double height = double.parse(heightController.text) / 100;
        double imc = weight / (height * height);
        if (imc < 18.6) {
          infoText =
              'Você está abaixo do peso! (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 18.6 && imc < 24.9) {
          infoText = 'Você está no peso ideal! (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 24.9 && imc < 29.9) {
          infoText = 'Levemente acima do peso (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 29.9 && imc < 34.9) {
          infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 34.9 && imc < 39.9) {
          infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(4)})';
        } else if (imc >= 40) {
          infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(4)})';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outlined,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira seu peso!';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                  ),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira sua Altura!';
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: Text('Calcular'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Text(
                  infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ],
            )),
      ),
    );
  }
}
