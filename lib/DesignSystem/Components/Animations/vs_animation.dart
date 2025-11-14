import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VsAnimation extends StatelessWidget {
  const VsAnimation({
    Key? key,
    this.height = 200,
    this.width = 200,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/vs.json',
      height: height,
      width: width,
      fit: BoxFit.contain,
    );
  }
}