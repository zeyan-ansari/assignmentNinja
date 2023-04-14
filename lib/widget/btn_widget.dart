import 'package:flutter/material.dart';

import '../HomePage.dart';

class button_widget extends StatelessWidget {
  const button_widget({
    super.key,
    required this.fun, required this.text, required this.color, required this.textColor,
  });

  final Function fun;
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 40,
          width: 73,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5)),
          child:  Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 12),
            child: Center(
                child: Text(
                  text,
                  style:  TextStyle(color: textColor),
                )),
          ),
        ),
        onTap: () =>
          fun()
        );
  }
}
