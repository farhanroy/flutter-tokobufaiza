import 'package:flutter/material.dart';

class FailureComponent extends StatelessWidget {
  final String message;

  const FailureComponent({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
