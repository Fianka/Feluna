import 'dart:async';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class TreatmentOlahnafasController extends GetxController {
  final isRunning = false.obs;
  final currentText = "Tarik".obs;
  final currentLoops = 0.obs;
  final targetLoops = 0.obs;
  final volume = 0.5.obs;
  final soundVolume = 0.5.obs;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  Timer? _timer;

  final List<String> _breathTexts = ["Tarik", "Tahan", "Buang"];
  int _breathIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> playSound(String soundPath) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setVolume(volume.value);
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  Future<void> playBackgroundSound(String soundPath) async {
    try {
      await _backgroundPlayer.stop();
      await _backgroundPlayer.setVolume(soundVolume.value);
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundPlayer.play(AssetSource(soundPath));
    } catch (e) {
      print("Error playing background sound: $e");
    }
  }

  void startBreathingSession(int loops) {
    if (isRunning.value) return;

    targetLoops.value = loops;
    currentLoops.value = 0;
    isRunning.value = true;
    _breathIndex = 0;
    currentText.value = _breathTexts[_breathIndex];

    playBackgroundSound('sound/meditation.mp3');
    _startBreathCycle();
  }

  void _startBreathCycle() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!isRunning.value) {
        timer.cancel();
        return;
      }

      _breathIndex = (_breathIndex + 1) % _breathTexts.length;
      currentText.value = _breathTexts[_breathIndex];

      if (_breathIndex == 0) {
        currentLoops.value++;
        if (currentLoops.value >= targetLoops.value) {
          stopBreathingSession();
        }
      }
    });
  }

  void stopBreathingSession() {
    _timer?.cancel();
    _backgroundPlayer.stop();
    isRunning.value = false;
  }

  @override
  void onClose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _backgroundPlayer.dispose();
    super.onClose();
  }
}
