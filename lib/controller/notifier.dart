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
      if (operator == '.') {
        expression =
            '0.'; // Empty string mein decimal se start karne pe add 0 automatically
      } else if (operator == ' - ') {
        expression = '-';
      } else if (isNumber) {
        expression = operator;
      }
    } else {
      if (operator == "C") {
        expression = '';
        result = '';
      } else if (operator == "⌫") {
        if (expression.endsWith(' ')) {
          expression = expression.substring(0, expression.length - 3);
        } else {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (expression.endsWith('.') && operator == '.') {
        return;
      } else if (expression.endsWith(' ') && operator == '.') {
        expression = expression + '0.';
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
    if (expression == '-') expression = '-';

    print(">>>>>>>>>>>>>>>>Before try catch");

    try {
      if (expression == '-') {
        result = '-';
      } else if (expression != '-' && expression.isNotEmpty) {
        var privateResult =
            expression.replaceAll('÷', '/').replaceAll('×', '*');
        Parser p = Parser();
        Expression exp = p.parse(privateResult);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (result.endsWith('.0')) {
          result = result.substring(0, result.length - 2);
          // Removing 0 from the end result ... agar float value result mein aati hai toh...
        }
      }
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
