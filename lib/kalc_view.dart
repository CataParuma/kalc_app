import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:kalc_app/kalc_button.dart';

class KalcView extends StatefulWidget {
  const KalcView({Key? key}) : super(key: key);

  @override
  State<KalcView> createState() => _KalcViewState();
}

class _KalcViewState extends State<KalcView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    // used to check if the result contains a decimal
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
          leading: const Icon(Icons.settings, color: Colors.greenAccent),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text('Alejandro Paruma', style: TextStyle(color: Colors.white38)),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(result,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 80))),
                        const Icon(Icons.more_vert,
                            color: Colors.greenAccent, size: 30),
                        const SizedBox(width: 20),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(equation,
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white38,
                              )),
                        ),
                        IconButton(
                          icon: const Icon(Icons.backspace_outlined,
                              color: Colors.greenAccent, size: 30),
                          onPressed: () {
                            buttonPressed("⌫");
                          },
                        ),
                        const SizedBox(width: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                kalcButton('0', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('0')),
                kalcButton('=', Colors.greenAccent, () => buttonPressed('=')),
                kalcButton('C', Colors.greenAccent, () => buttonPressed('C')),
                kalcButton("+", Colors.greenAccent, () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                kalcButton('1', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('1')),
                kalcButton('2', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('2')),
                kalcButton('3', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('3')),
                kalcButton('-', Colors.greenAccent, () => buttonPressed('-')),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                kalcButton('4', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('4')),
                kalcButton('5', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('5')),
                kalcButton('6', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('6')),
                kalcButton('×', Colors.greenAccent, () => buttonPressed('×')),
              ],
            ),
          const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                kalcButton('7', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('7')),
                kalcButton('8', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('8')),
                kalcButton('9', const Color.fromARGB(255, 38, 4, 44), () => buttonPressed('9')),
                kalcButton('÷', Colors.greenAccent, () => buttonPressed('÷')),
              ],
            ),
            

            
          ],
        )));
  }
}
