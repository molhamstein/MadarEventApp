import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;

  const DecoratedContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: child,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.white], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
    );
  }
}
