import 'dart:io';

import 'package:bmi_calculator/functional_classes/current_toast.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import 'functional_classes/access_storage.dart';
import 'sub_widgets/custom_card.dart';

const cardMainColor = Color(0xFF111428);
const lightsOff = Color(0xFF878892);
String clientName = "";
bool haveToSave = false;

class ResultPage extends StatelessWidget {
  final ScreenshotController screenshotController = ScreenshotController();
  ResultPage(
      {this.bmiOfClient,
      this.conditionOfClient,
      this.colorOfConditionOfClient,
      this.noteForClient});
  final double bmiOfClient;
  final String conditionOfClient;
  final Color colorOfConditionOfClient;
  final String noteForClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
                      child: Text(
                        'Your Result',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Screenshot(
                        controller: screenshotController,
                        child: CustomCard(
                          cardColor: cardMainColor,
                          marginOfAllSides: 0.0,
                          cardChild: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      conditionOfClient.toUpperCase(),
                                      style: TextStyle(
                                          color: colorOfConditionOfClient,
                                          letterSpacing: 1,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      bmiOfClient.toStringAsFixed(1),
                                      style: TextStyle(fontSize: 60.0),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Normal BMI range:',
                                      style: TextStyle(
                                        color: lightsOff,
                                        letterSpacing: 1,
                                        height: 1.5,
                                      ),
                                    ),
                                    Text(
                                      '18.5 - 25 kg/m2',
                                      style: TextStyle(height: 1.5),
                                    ),
                                  ],
                                ),
                                Text(
                                  noteForClient,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Column(
                                  children: [
                                    FlatButton(
                                      onPressed: () {
                                        saveScreenshot(context);
                                      },
                                      child: Text(
                                        'SAVE RESULT',
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          height: 0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      color: Color(0xFF181A2E),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        shareScreenshot(context);
                                      },
                                      child: Text(
                                        'SHARE',
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          height: 0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      color: Color(0xFF181A2E),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            child: Text(
              'RE-CALCULATE YOUR BMI',
              style: TextStyle(fontSize: 15.0, letterSpacing: 2.0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void saveScreenshot(BuildContext context) async {
    var permissionStatus = await Permission.storage.status;
    if (permissionStatus.isGranted) {
      showDialog(context: context, builder: (context) => ShowDialogBox())
          .whenComplete(() {
        if (haveToSave) {
          if (clientName == "")
            clientName =
                (DateTime.now().toString().replaceAll(' ', '_') + '_BMI.png');
          else
            clientName = ((clientName.toLowerCase().replaceAll(' ', '_'))
                    .replaceAll('.', '') +
                '_BMI.png');
          screenshotController.capture().then((File image) async {
            StorageOfPhone(clientName)
                .writeCounter(image.readAsBytesSync(), context);
          }).catchError((onError) {
            print(onError);
          });
        }
      });
    } else if (permissionStatus.isPermanentlyDenied) {
      CurrentToast(context, 'Please provide "Storage Permission" to save BMI')
          .showCurrentCondition();
    } else {
      await Permission.storage.request();
    }
  }

  void shareScreenshot(BuildContext context) {
    screenshotController.capture().then((File image) async {
      Share.file('BMI', DateTime.now().toString().replaceAll(' ', '') + '.png',
          image.readAsBytesSync(), 'image/png',
          text: 'My BMI');
    }).catchError((onError) {
      print(onError);
    });
  }
}

class ShowDialogBox extends StatefulWidget {
  @override
  _ShowDialogBoxState createState() => _ShowDialogBoxState();
}

class _ShowDialogBoxState extends State<ShowDialogBox> {
  @override
  void initState() {
    super.initState();
    haveToSave = false;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Enter Your Name'),
      elevation: 20.0,
      children: [
        SimpleDialogOption(
          child: TextField(
            onChanged: (String data) {
              clientName = data;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        SimpleDialogOption(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  haveToSave = true;
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
