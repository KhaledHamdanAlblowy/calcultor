import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: SimpleCalculator(),
    );
  }
}

//statful
class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expresion = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttontext) {
    setState(() {
      if (buttontext == "C") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = '0';
        result = '0';
      } else if (buttontext == '⌫') {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
      } else if (buttontext == '=') {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expresion = equation;
        equation = expresion.replaceAll('×', '*');
        equation = expresion.replaceAll("÷", '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expresion);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == '0') {
          equation = buttontext;
        } else {
          equation = equation + buttontext;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      color: buttonColor,
      child: ElevatedButton(
        onPressed: () {
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          padding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Simple Calculator',
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.red),
                        buildButton('⌫', 1, Colors.blue),
                        buildButton('÷', 1, Colors.blue)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.black54),
                        buildButton('8', 1, Colors.black54),
                        buildButton('9', 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.black54),
                        buildButton('5', 1, Colors.black54),
                        buildButton('6', 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.black54),
                        buildButton('2', 1, Colors.black54),
                        buildButton('3', 1, Colors.black54)
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.black54),
                        buildButton('0', 1, Colors.black54),
                        buildButton('00', 1, Colors.black54)
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [buildButton('×', 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buildButton('-', 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buildButton('+', 1, Colors.blue)],
                    ),
                    TableRow(
                      children: [buildButton('=', 2, Colors.red)],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
