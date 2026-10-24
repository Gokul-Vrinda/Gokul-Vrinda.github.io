// lib/providers/audio_provider.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_audio.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  bool _isInitialized = false;

  bool get isPlaying => _audioPlayer.playing;

  AudioProvider() {
    debugPrint("🎵 [AudioProvider] Initializing player...");
    _audioPlayer = AudioPlayer();

    _audioPlayer.playerStateStream.listen((state) {
      debugPrint("🔊 [just_audio State] Playing: ${state.playing}");
      notifyListeners();
    });

    _initAndPlayAudio();
  }

  Future<void> _initAndPlayAudio() async {
    if (_isInitialized) return;
    try {
      // 🚀 Preload audio asset with low latency flag for web
      await _audioPlayer.setAsset(AppAudio.weddingSong);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _isInitialized = true;

      // Attempt auto-play (Browsers might block this until user interacts, which is handled gracefully by catch)
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("⚠️ [Autoplay Blocked/Error by Browser]: $e");
    }
  }

  Future<void> togglePlayPause() async {
    try {
      if (!_isInitialized) {
        await _initAndPlayAudio();
        return;
      }

      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e) {
      debugPrint("❌ [Toggle Error]: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
