import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:nawgati_calc/models/provider_models/history.dart';

class CalProvider with ChangeNotifier {
  String expression = '';
  String result = '';
  List<HisModel> history = Hive.box<HisModel>('history')
      .values
      .toList()
      .reversed
      .toList()
      .cast<HisModel>();

  void deleteHistory() {
    Hive.box<HisModel>('history').clear();
    history.clear();
    notifyListeners();
  }

  void addCharacter(String operator, bool isNumber, BuildContext context) {
    if (expression == '') {
      // Empty string mein starting with decimal toh automatically add 0 to expression
      if (operator == '.') {
        expression = '0.';
      } else if (operator == ' - ') {
        expression = '-';
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
        if (expression != '-') {
          final hisModel = HisModel()
            ..res = result
            ..calculations = expression;
          Hive.box<HisModel>('history').add(hisModel);
          history = Hive.box<HisModel>('history')
              .values
              .toList()
              .reversed
              .toList()
              .cast<HisModel>();
          notifyListeners();
          // ignore: avoid_print
          print('Saved to history');
        }
      } else {
        expression += operator;
      }
    }

    if (expression == '0') expression = '';

    print(">>>>>>>>>>>>>>>>Before try catch");
    if (expression == '-') {
      result = '-';
    } else if (expression.isNotEmpty) {
      // Actual operators se replacing ... in the expression
      var actualExp = expression.replaceAll('÷', '/').replaceAll('×', '*');
      Parser p = Parser();
      print("????????????? Before Parsing");
      Expression exp = p.parse(actualExp);
      print("????????????? After Parsing");
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (result.endsWith('.0')) {
        result = result.substring(
            0, result.length - 2); // removing ".0" from the end result
      }
    }

    notifyListeners();
  }
}
