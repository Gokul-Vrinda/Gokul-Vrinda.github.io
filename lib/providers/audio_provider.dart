// lib/providers/audio_provider.dart
import 'package:flutter/material.dart';
import 'package:gokul_weds_vrinda/const/app_audio.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  bool _isInitialized = false;

  // Always return the actual player playing state to prevent desync double-clicks
  bool get isPlaying => _audioPlayer.playing;

  AudioProvider() {
    debugPrint("🎵 [AudioProvider] Initializing player...");
    _audioPlayer = AudioPlayer();
    
    // Listen to player state changes to automatically trigger UI rebuilds
    _audioPlayer.playerStateStream.listen((state) {
      debugPrint("🔊 [just_audio State] Playing: ${state.playing}");
      notifyListeners();
    });

    _initAndPlayAudio();
  }

  Future<void> _initAndPlayAudio() async {
    if (_isInitialized) return;
    try {
      await _audioPlayer.setAsset(AppAudio.weddingSong);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _isInitialized = true;
      
      // Auto-play on start
      await _audioPlayer.play();
    } catch (e) {
      debugPrint("⚠️ [Autoplay Error]: $e");
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