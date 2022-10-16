import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:nawgati_calc/models/provider_models/history.dart';

class CalProvider with ChangeNotifier {
  String expression = '';
  String result = '';

  void addCharacter(String operator, bool isNumber, BuildContext context) {
    if (expression == '0') expression = '';
    if (expression == '') {
      // Empty string mein starting with decimal toh automatically add 0 to expression
      if (operator == '.') {
        expression = '0.';
      } else if (isNumber) {
        expression = operator;
      }
    } else {
      if (operator == 'C') {
        expression = '';
        result = '';
      } else if (operator == '⌫') {
        if (expression.endsWith(' ')) {
          // Expression ke end mein operator hai but no number toh removing...
          expression = expression.substring(0, expression.length - 3);
        } else {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (expression.endsWith('.') && operator == '.') {
        return;
      } else if (expression.endsWith(' ') && operator == '.') {
        expression += '0.';
      } else if (expression.endsWith(' ') && isNumber == false) {
        expression = expression.substring(0, expression.length - 3) + operator;
      } else if (operator == '=') {
        final hisModel = HisModel()
          ..res = result
          ..calculations = expression;
        Hive.box<HisModel>('history').add(hisModel);
        // ignore: avoid_print
        print('Saved to history');
      } else {
        expression += operator;
      }
    }

    try {
      // Actual operators se replacing ... in the expression
      var actualExp = expression.replaceAll('÷', '/').replaceAll('×', '*');
      Parser p = Parser();
      Expression exp = p.parse(actualExp);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (result.endsWith('.0')) {
        result = result.substring(
            0, result.length - 2); // removing ".0" from the end result
      }
    } catch (e) {
      result = '';
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Some Error occurred'),
        duration: Duration(milliseconds: 400),
      ));
    }

    notifyListeners();
  }
}
