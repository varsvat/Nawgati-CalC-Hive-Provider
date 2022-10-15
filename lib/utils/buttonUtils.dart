import 'package:flutter/material.dart';
import 'package:nawgati_calc/utils/consts.dart';

class CalculatorButton extends StatelessWidget {
  final String label;
  final bool isColored, isEqualSign, canBeFirst;
  const CalculatorButton(
    this.label, {
    this.isColored = false,
    this.isEqualSign = false,
    this.canBeFirst = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final calculatorProvider =
    //     Provider.of<CalculatorProvider>(context, listen: false);
    final TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    final mediaQuery = MediaQuery.of(context).size;
    return Material(
      color: greyish,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(40.0),
          onTap: () {
            // calculatorProvider.addToEquation(
            //   label,
            //   canBeFirst,
            //   context,
            // );
            print('pressed');
          },
          child: Center(
            child: isEqualSign
                ? Container(
                    height: mediaQuery.width * 0.1,
                    width: mediaQuery.width * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: blueSplash,
                    ),
                    child: Center(
                      child: Text(
                        label,
                        style: textStyle?.copyWith(color: greyish),
                      ),
                    ),
                  )
                : Text(
                    label,
                    style: textStyle?.copyWith(
                        color: isColored ? blueSplash : Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}

List<CalculatorButton> buttons = <CalculatorButton>[
  CalculatorButton('C', isColored: true, canBeFirst: false),
  CalculatorButton(' % ', isColored: true, canBeFirst: false),
  CalculatorButton('⌫', isColored: true, canBeFirst: false),
  CalculatorButton(' ÷ ', isColored: true, canBeFirst: false),
  CalculatorButton('7'),
  CalculatorButton('8'),
  CalculatorButton('9'),
  CalculatorButton(' × ', isColored: true, canBeFirst: false),
  CalculatorButton('4'),
  CalculatorButton('5'),
  CalculatorButton('6'),
  CalculatorButton(' - ', isColored: true, canBeFirst: false),
  CalculatorButton('1'),
  CalculatorButton('2'),
  CalculatorButton('3'),
  CalculatorButton(' + ', isColored: true, canBeFirst: false),
  CalculatorButton('00'),
  CalculatorButton('0'),
  CalculatorButton('000'),
  CalculatorButton('=', isEqualSign: true, canBeFirst: false),
];
