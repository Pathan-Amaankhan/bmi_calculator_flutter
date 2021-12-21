import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

const lightsOff = Color(0xFF878892);
const lightsOn = Color(0xFFFFFFFF);

class WeightAgeCustomColumn extends StatefulWidget {
  final String cardTitle;
  int cardNumber;

  double getNumberOnCard() {
    return cardNumber.toDouble();
  }

  WeightAgeCustomColumn({@required this.cardTitle, @required this.cardNumber});
  @override
  _WeightAgeCustomColumnState createState() =>
      _WeightAgeCustomColumnState(this.cardTitle, this.cardNumber);
}

class _WeightAgeCustomColumnState extends State<WeightAgeCustomColumn> {
  _WeightAgeCustomColumnState(this.cardTitle, this._cardNumber);

  final String cardTitle;
  int _cardNumber;
  Timer decrementalTimer;
  Timer incrementalTimer;

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
            child: Text(
              _cardNumber.toString(),
              style: TextStyle(fontSize: 50.0),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularButton(
                  btnIcon: Icons.remove,
                  onPressFunction: () => haveToDecrement(),
                  onLongPressStartFunction: (LongPressStartDetails details) {
                    Wakelock.enable();
                    decrementalTimer = Timer.periodic(
                        Duration(milliseconds: 100), (t) => haveToDecrement());
                  },
                  onLongPressUpFunction: () => clearDecrementTimer(),
                  onLongPressEndFunction: (LongPressEndDetails details) =>
                      clearDecrementTimer(),
                ),
                CircularButton(
                  btnIcon: Icons.add,
                  onPressFunction: () => haveToIncrement(),
                  onLongPressStartFunction: (LongPressStartDetails details) {
                    Wakelock.enable();
                    incrementalTimer = Timer.periodic(
                        Duration(milliseconds: 100), (t) => haveToIncrement());
                  },
                  onLongPressEndFunction: (LongPressEndDetails details) =>
                      clearIncrementTimer(),
                  onLongPressUpFunction: () => clearIncrementTimer(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void haveToIncrement() {
    if ((cardTitle.toLowerCase() == 'weight' && _cardNumber < 600) ||
        (cardTitle.toLowerCase() == 'age' && _cardNumber < 200)) {
      setState(() {
        _cardNumber++;
        widget.cardNumber++;
      });
    }
  }

  void haveToDecrement() {
    if (_cardNumber > 1) {
      setState(() {
        _cardNumber--;
        widget.cardNumber--;
      });
    }
  }

  void clearDecrementTimer() {
    Wakelock.disable();
    decrementalTimer.cancel();
  }

  void clearIncrementTimer() {
    Wakelock.disable();
    incrementalTimer.cancel();
  }
}

class CircularButton extends StatelessWidget {
  CircularButton(
      {@required this.btnIcon,
      @required this.onPressFunction,
      this.onLongPressFunction,
      this.onLongPressStartFunction,
      this.onLongPressEndFunction,
      this.onLongPressUpFunction});
  final IconData btnIcon;
  final Function onPressFunction;
  final Function onLongPressFunction;
  final Function(LongPressStartDetails details) onLongPressStartFunction;
  final Function(LongPressEndDetails details) onLongPressEndFunction;
  final Function onLongPressUpFunction;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressFunction,
      shape: CircleBorder(),
      child: GestureDetector(
        child: Icon(btnIcon),
        onLongPress: onLongPressFunction,
        onLongPressStart: onLongPressStartFunction,
        onLongPressUp: onLongPressUpFunction,
        onLongPressEnd: onLongPressEndFunction,
      ),
      fillColor: Color(0xFF1C1F32),
      splashColor: Colors.white,
      elevation: 6.0,
      highlightElevation: 12.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
    );
  }
}
