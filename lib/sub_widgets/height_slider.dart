import 'package:flutter/material.dart';

const lightsOff = Color(0xFF878892);

class HeightCustomColumn extends StatefulWidget {
  HeightCustomColumn({this.cardTitle});
  final String cardTitle;
  double cardNumber = 50;

  double getHeight() {
    return cardNumber;
  }

  @override
  _HeightCustomColumnState createState() =>
      _HeightCustomColumnState(cardNumber, cardTitle);
}

class _HeightCustomColumnState extends State<HeightCustomColumn> {
  _HeightCustomColumnState(this._currentSliderValue, this.cardTitle);
  final String cardTitle;
  double _currentSliderValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              cardTitle.toUpperCase(),
              style: TextStyle(color: lightsOff),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _currentSliderValue.round().toString(),
                  style: TextStyle(fontSize: 50.0),
                ),
                Text(
                  'cm',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: lightsOff,
                    fontWeight: FontWeight.w500,
                    height: 3.5,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Slider(
              value: _currentSliderValue,
              min: 20,
              max: 400,
              divisions: 380,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                  widget.cardNumber = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
