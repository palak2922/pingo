import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final double size;

  CustomLoader({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitRipple(
      color: color,
      size: size,
    );
  }
}
