import 'package:flutter/material.dart';
import 'package:nawgati_calc/controller/notifier.dart';
import 'package:nawgati_calc/utils/consts.dart';
import 'package:provider/provider.dart';

class CalculatorButton extends StatelessWidget {
  final String character;
  final bool isColor, isNumber, isEquals;
  const CalculatorButton(
    this.character, {
    this.isColor = false,
    this.isNumber = true,
    this.isEquals = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<CalProvider>(context, listen: false);
    final TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    final mediaQuery = MediaQuery.of(context).size;
    return Material(
      color: greyish,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(40.0),
          onTap: () {
            provider.addCharacter(
              character,
              isNumber,
              context,
            );
            print('pressed');
          },
          child: Center(
            child: Text(
                    character,
                    style: textStyle?.copyWith(
                        color: isColor ? blueSplash : Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}

List<CalculatorButton> buttons = <CalculatorButton>[
  CalculatorButton('C', isColor: true, isNumber: false),
  CalculatorButton('.', isColor: true, isNumber: false),
  CalculatorButton('⌫', isColor: true, isNumber: false),
  CalculatorButton(' ÷ ', isColor: true, isNumber: false),
  CalculatorButton('7'),
  CalculatorButton('8'),
  CalculatorButton('9'),
  CalculatorButton(' × ', isColor: true, isNumber: false),
  CalculatorButton('4'),
  CalculatorButton('5'),
  CalculatorButton('6'),
  CalculatorButton(' - ', isColor: true, isNumber: false),
  CalculatorButton('1'),
  CalculatorButton('2'),
  CalculatorButton('3'),
  CalculatorButton(' + ', isColor: true, isNumber: false),
  CalculatorButton('00'),
  CalculatorButton('0'),
  CalculatorButton('000'),
  CalculatorButton('=', isEquals: true, isNumber: false),
];
