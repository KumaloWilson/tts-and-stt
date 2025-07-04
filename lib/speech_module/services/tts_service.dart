import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TTSService extends GetxService {
  late FlutterTts _flutterTts;
  
  final RxBool _isPlaying = false.obs;
  final RxDouble _speechRate = 0.5.obs;
  final RxDouble _speechPitch = 1.0.obs;
  final RxDouble _speechVolume = 0.8.obs;
  final RxList<String> _languages = <String>[].obs;
  final RxString _selectedLanguage = 'en-US'.obs;

  bool get isPlaying => _isPlaying.value;
  double get speechRate => _speechRate.value;
  double get speechPitch => _speechPitch.value;
  double get speechVolume => _speechVolume.value;
  List<String> get languages => _languages;
  String get selectedLanguage => _selectedLanguage.value;

  @override
  void onInit() {
    super.onInit();
    _initializeTTS();
  }

  Future<void> _initializeTTS() async {
    _flutterTts = FlutterTts();
    
    await _flutterTts.setLanguage(_selectedLanguage.value);
    await _flutterTts.setSpeechRate(_speechRate.value);
    await _flutterTts.setPitch(_speechPitch.value);
    await _flutterTts.setVolume(_speechVolume.value);

    _flutterTts.setStartHandler(() {
      _isPlaying.value = true;
    });

    _flutterTts.setCompletionHandler(() {
      _isPlaying.value = false;
    });

    _flutterTts.setErrorHandler((msg) {
      _isPlaying.value = false;
      Get.snackbar(
        'TTS Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    });

    // Get available languages
    List<dynamic> languages = await _flutterTts.getLanguages;
    _languages.value = languages.cast<String>();
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _isPlaying.value = false;
  }

  Future<void> pause() async {
    await _flutterTts.pause();
    _isPlaying.value = false;
  }

  void setSpeechRate(double rate) {
    _speechRate.value = rate;
    _flutterTts.setSpeechRate(rate);
  }

  void setSpeechPitch(double pitch) {
    _speechPitch.value = pitch;
    _flutterTts.setPitch(pitch);
  }

  void setSpeechVolume(double volume) {
    _speechVolume.value = volume;
    _flutterTts.setVolume(volume);
  }

  void setLanguage(String language) {
    _selectedLanguage.value = language;
    _flutterTts.setLanguage(language);
  }
}
