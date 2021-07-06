import 'package:flutter/material.dart';

class EmptyComponent extends StatelessWidget {
  final String message;

  const EmptyComponent({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}