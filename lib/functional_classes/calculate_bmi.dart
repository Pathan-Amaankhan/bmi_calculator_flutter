import 'dart:math';

import 'package:flutter/material.dart';

class CalculateBmi {
  double _height;
  double _weight;
  double _bmi;
  String _note;
  String _condition;
  Color _conditionColor;

  CalculateBmi({height, weight}) {
    this._height = height;
    this._weight = weight;
    this._bmi = (_weight / pow((_height / 100), 2));
    if (_bmi < 18.5) {
      this._note = 'You are under weight. Eat Well!';
      this._condition = 'Under weight';
      this._conditionColor = Colors.red;
    } else if (_bmi <= 25) {
      this._note = 'You have a normal body weight. Good job!';
      this._condition = 'Normal';
      this._conditionColor = Colors.green;
    } else {
      this._note = 'You need to reduce weight. Eat Healthy!';
      this._condition = 'Over weight';
      this._conditionColor = Colors.red;
    }
  }

  double getBmi() {
    return _bmi;
  }

  String getNote() {
    return _note;
  }

  String getCondition() {
    return _condition;
  }

  Color getColorOfCondition() {
    return _conditionColor;
  }
}
