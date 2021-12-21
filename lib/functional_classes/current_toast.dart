import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class CurrentToast {
  BuildContext context;
  String textToDisplay;
  CurrentToast(this.context, this.textToDisplay);
  void showCurrentCondition() {
    showToast(textToDisplay,
        context: context,
        textStyle: TextStyle(letterSpacing: 1, fontSize: 15.0),
        animation: StyledToastAnimation.slideFromLeftFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        toastHorizontalMargin: 0.0,
        position: StyledToastPosition(align: Alignment.topLeft, offset: 20.0),
        startOffset: Offset(-1.0, 0.0),
        reverseEndOffset: Offset(-1.0, 0.0),
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 1),
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.fastOutSlowIn);
  }
}
