import 'package:flutter/material.dart';

enum AlertType { error, success, info }

class AlertModal extends ModalRoute<void> {
  final String title;
  final String message;
  final Function yesFunction;
  final AlertType type;
  final String yesText;

  AlertModal({
    required this.title,
    required this.message,
    required this.yesFunction,
    this.type = AlertType.info,
    this.yesText = 'OK',
  });

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'Alert Modal';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            yesFunction();
            Navigator.of(context).pop();
          },
          child: Text(yesText),
        ),
      ],
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;
}
