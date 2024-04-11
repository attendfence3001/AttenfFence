import 'package:flutter/material.dart';

class ScaffoldWithBackground extends StatelessWidget {
  const ScaffoldWithBackground({
    Key? key,
    required this.backgroundImagePath,
    this.backButton = true,
    this.onTap,
    required this.body,
  }) : super(key: key);

  final String backgroundImagePath;
  final Widget body;
  final bool backButton;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            backgroundImagePath,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black45,
          ),
          body,
        ],
      ),
    );
  }
}
