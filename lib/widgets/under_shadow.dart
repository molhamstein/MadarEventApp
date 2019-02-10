import 'package:flutter/material.dart';

class UnderShadow extends StatelessWidget {

  final Widget child;

  const UnderShadow({Key key, this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12
          ),
        ],
      ),
    );
  }

}