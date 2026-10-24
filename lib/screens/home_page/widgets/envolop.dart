import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_assets.dart';

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
              AppAssets.envelopeBack,
              width: 900,
              height: 680,
              filterQuality: FilterQuality.low,
            ),
            Positioned(
              top: 8,
              right: 30,
              child: Transform.rotate(
                angle: 0.3,
                child: Image.asset(
                  AppAssets.poster,
                  width: 700,
                  height: 480,
                  filterQuality: FilterQuality.low,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 70,
              child: Image.asset(
                AppAssets.flower,
                width: 500,
                height: 480,
                filterQuality: FilterQuality.low,
              ),
            ),
            Image.asset(
              AppAssets.envelopeFront,
              width: 900,
              height: 680,
              filterQuality: FilterQuality.low,
            ),
          ],
        ),
      ),
    );
  }
}
