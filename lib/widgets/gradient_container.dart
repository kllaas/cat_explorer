import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const GradientContainer({
    Key key,
    @required this.color,
    @required this.child,
  })  : assert(color != null, child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 0.7, 1.0],
          colors: [
            color.withOpacity(1.0),
            color.withOpacity(0.7),
            color.withOpacity(0.8),
          ],
        ),
      ),
      child: child,
    );
  }
}
