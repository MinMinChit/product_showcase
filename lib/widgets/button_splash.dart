import 'package:flutter/material.dart';

enum BtnShape {
  circle,
  rectangle,
}

class SplashButton extends StatelessWidget {
  const SplashButton({
    super.key,
    this.onTap,
    required this.child,
    this.splashSize = 40,
    this.btnShape = BtnShape.circle,
    this.iconSize = 24,
    this.color = Colors.transparent,
  });

  final Function()? onTap;
  final Widget child;
  final double splashSize;
  final BtnShape btnShape;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(splashSize);
    if (btnShape == BtnShape.rectangle) {
      borderRadius = BorderRadius.zero;
    }
    return Material(
      borderRadius: borderRadius,
      color: color,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          height: splashSize,
          width: splashSize,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: EdgeInsets.all((splashSize - iconSize) / 2),
            child: child,
          ),
        ),
      ),
    );
  }
}
