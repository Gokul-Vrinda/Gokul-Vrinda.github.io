import 'package:flutter/material.dart';

class Envolop extends StatelessWidget {
  const Envolop({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain, // keeps aspect ratio, never distorts
      child: SizedBox(
        width: 900, // design canvas
        height: 680,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior:
              Clip.none, // lets the rotated poster overflow without clipping
          children: [
            Image.asset(
              "assets/images/letter_cover_back.png",
              width: 900,
              height: 680,
            ),
            Positioned(
              top: 8,
              right: 30,
              child: Transform.rotate(
                angle: 0.3,
                child: Image.asset(
                  "assets/images/Poster.png",
                  width: 700,
                  height: 480,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 70,
              child: Image.asset(
                "assets/images/Flower.png",
                width: 500,
                height: 480,
              ),
            ),
            Image.asset(
              "assets/images/letter_cover_front.png",
              width: 900,
              height: 680,
            ),
          ],
        ),
      ),
    );
  }
}
