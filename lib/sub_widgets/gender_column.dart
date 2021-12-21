import 'package:flutter/material.dart';

class MaleFemaleCustomColumn extends StatelessWidget {
  MaleFemaleCustomColumn(
      {@required this.cardIcon,
      @required this.cardText,
      @required this.cardTextColor,
      @required this.cardIconColor});
  final IconData cardIcon;
  final String cardText;
  final Color cardTextColor;
  final Color cardIconColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          cardIcon,
          size: 70.0,
          color: cardIconColor,
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          cardText.toUpperCase(),
          style: TextStyle(color: cardTextColor),
        ),
      ],
    );
  }
}
