// import 'package:flutter/material.dart';
// import 'package:gokul_weds_vrinda/const/app_assets.dart';

// class Envolop extends StatelessWidget {
//   const Envolop({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FittedBox(
//       fit: BoxFit.contain, // keeps aspect ratio, never distorts
//       child: SizedBox(
//         width: 900, // design canvas
//         height: 680,
//         child: Stack(
//           alignment: Alignment.center,
//           clipBehavior:
//               Clip.none, // lets the rotated poster overflow without clipping
//           children: [
//             Image.asset(
//               AppAssets.envelopeBack,
//               width: 900,
//               height: 680,
//               filterQuality: FilterQuality.low,
//             ),
//             Positioned(
//               top: 8,
//               right: 30,
//               child: Transform.rotate(
//                 angle: 0.3,
//                 child: Image.asset(
//                   AppAssets.poster,
//                   width: 700,
//                   height: 480,
//                   filterQuality: FilterQuality.low,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 20,
//               left: 70,
//               child: Image.asset(
//                 AppAssets.flower,
//                 width: 500,
//                 height: 480,
//                 filterQuality: FilterQuality.low,
//               ),
//             ),
//             Image.asset(
//               AppAssets.envelopeFront,
//               width: 900,
//               height: 680,
//               filterQuality: FilterQuality.low,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_assets.dart';
import 'package:gokul_weds_vrinda/const/screen_helper.dart';

class Envolop extends StatefulWidget {
  const Envolop({super.key});

  @override
  State<Envolop> createState() => _EnvolopState();
}

class _EnvolopState extends State<Envolop> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -8.0,
      end: 8.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(const AssetImage(AppAssets.envelope), context);
    precacheImage(const AssetImage(AppAssets.envelopeBack), context);
    precacheImage(const AssetImage(AppAssets.envelopeFront), context);
    precacheImage(const AssetImage(AppAssets.flower), context);
    precacheImage(const AssetImage(AppAssets.poster), context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobileCheck = ScreenHelper.isMobile(context);

    // 📱 MOBILE: Direct size kooti kodukkunnu (Width 900-nu pakaram 1100 allel 1200 aakki kooti nokkam)
    if (mobileCheck) {
      const double customWidth = 600.0;
      const double customHeight = 400.0;

      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value), // Vertical floating animation
            child: child,
          );
        },
        child: Image.asset(
          AppAssets.envelope, // Make sure your asset name is correct
          width: customWidth,
          height: customHeight,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.low,
        ),
      );
    }

    // 💻 DESKTOP: Original multi-layer design stack with FittedBox
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: 900,
        height: 680,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
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
