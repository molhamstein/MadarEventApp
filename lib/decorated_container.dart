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
          image: DecorationImage(
              image: AssetImage('assets/images/istanbul.png'),
              fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
      ),
    );
  }
}
