// lib/screens/home_page/widgets/music_button.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gokul_weds_vrinda/providers/audio_provider.dart';

class MusicButton extends StatefulWidget {
  const MusicButton({super.key});

  @override
  State<MusicButton> createState() => _MusicButtonState();
}

class _MusicButtonState extends State<MusicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _rippleController;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        final isPlaying = audioProvider.isPlaying;

        return AnimatedBuilder(
          animation: _rippleController,
          builder: (context, child) {
            double scale = isPlaying
                ? (1.0 + (_rippleController.value * 0.2))
                : 1.0;
            int opacity = isPlaying
                ? ((0.5 - (_rippleController.value * 0.5)) * 255).toInt()
                : 0;

            return SizedBox(
              width: 75,
              height: 75,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isPlaying)
                    Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF5A1A2B).withAlpha(opacity),
                        ),
                      ),
                    ),

                  FloatingActionButton(
                    onPressed: () {
                      audioProvider.togglePlayPause();
                    },
                    backgroundColor: const Color(0xFF5A1A2B),
                    elevation: 4,
                    shape: const CircleBorder(),
                    child: Icon(
                      isPlaying ? Icons.music_note : Icons.music_off,
                      color: const Color(0xFFF9F6EE),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
