import 'package:bmi_calculator/functional_classes/calculate_bmi.dart';
import 'package:bmi_calculator/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'sub_widgets/custom_card.dart';
import 'sub_widgets/gender_column.dart';
import 'sub_widgets/height_slider.dart';
import 'sub_widgets/weight_age_column.dart';

const cardMainColor = Color(0xFF111428);
const lightsOff = Color(0xFF878892);
const lightsOn = Color(0xFFFFFFFF);

var heightCustomColumn = HeightCustomColumn(cardTitle: 'Height');
var weightCustomColumn =
    WeightAgeCustomColumn(cardTitle: 'Weight', cardNumber: 74);
var ageCustomColumn = WeightAgeCustomColumn(cardTitle: 'Age', cardNumber: 19);

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: MaleFemaleRow(),
          ),
          Expanded(
            child: CustomCard(
              cardColor: cardMainColor,
              cardChild: heightCustomColumn,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCard(
                    cardColor: cardMainColor,
                    cardChild: weightCustomColumn,
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    cardColor: cardMainColor,
                    cardChild: ageCustomColumn,
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: Text(
              'CALCULATE YOUR BMI',
              style: TextStyle(fontSize: 15.0, letterSpacing: 2.0),
            ),
            onPressed: () {
              CalculateBmi bmiCalculator = CalculateBmi(
                  height: heightCustomColumn.getHeight(),
                  weight: weightCustomColumn.getNumberOnCard());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    bmiOfClient: bmiCalculator.getBmi(),
                    conditionOfClient: bmiCalculator.getCondition(),
                    colorOfConditionOfClient:
                        bmiCalculator.getColorOfCondition(),
                    noteForClient: bmiCalculator.getNote(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MaleFemaleCard extends StatelessWidget {
  MaleFemaleCard(this._cardText, this._cardIcon, this._cardColor);
  final String _cardText;
  final IconData _cardIcon;
  final _cardColor;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      cardColor: cardMainColor,
      cardChild: MaleFemaleCustomColumn(
        cardIcon: _cardIcon,
        cardText: _cardText,
        cardTextColor: _cardColor,
        cardIconColor: _cardColor,
      ),
    );
  }
}

class MaleFemaleRow extends StatefulWidget {
  Color maleCardLights = lightsOn;
  Color femaleCardLights = lightsOff;

  String whichCardIsOn() {
    return maleCardLights == lightsOn ? 'male' : 'female';
  }

  @override
  _MaleFemaleRowState createState() => _MaleFemaleRowState();
}

class _MaleFemaleRowState extends State<MaleFemaleRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onMaleCardTap,
            child: MaleFemaleCard(
                'Male', FontAwesomeIcons.mars, widget.maleCardLights),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onFemaleCardTap,
            child: MaleFemaleCard(
                'Female', FontAwesomeIcons.venus, widget.femaleCardLights),
          ),
        ),
      ],
    );
  }

  void onMaleCardTap() {
    if (widget.maleCardLights == lightsOff) {
      setState(() {
        widget.maleCardLights = lightsOn;
        widget.femaleCardLights = lightsOff;
      });
    }
  }

  void onFemaleCardTap() {
    if (widget.femaleCardLights == lightsOff) {
      setState(() {
        widget.femaleCardLights = lightsOn;
        widget.maleCardLights = lightsOff;
      });
    }
  }
}
