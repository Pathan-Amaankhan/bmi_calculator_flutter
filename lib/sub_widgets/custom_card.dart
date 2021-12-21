import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {@required this.cardColor,
      @required this.cardChild,
      this.marginOfAllSides});

  final Color cardColor;
  final Widget cardChild;
  final double marginOfAllSides;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.all(
          ((marginOfAllSides == null) ? 10.0 : marginOfAllSides)),
      child: cardChild,
    );
  }
}
