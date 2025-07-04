import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../services/tts_service.dart';
import '../services/speech_service.dart';

class SpeechController extends GetxController {
  final TTSService _ttsService = Get.find<TTSService>();
  final SpeechService _speechService = Get.find<SpeechService>();
  
  final TextEditingController textController = TextEditingController();
  final RxInt _currentTabIndex = 0.obs;
  final RxBool _isTextEmpty = true.obs;

  int get currentTabIndex => _currentTabIndex.value;
  bool get isTextEmpty => _isTextEmpty.value;

  // TTS getters
  bool get isTTSPlaying => _ttsService.isPlaying;
  double get speechRate => _ttsService.speechRate;
  double get speechPitch => _ttsService.speechPitch;
  double get speechVolume => _ttsService.speechVolume;
  List<String> get ttsLanguages => _ttsService.languages;
  String get selectedTTSLanguage => _ttsService.selectedLanguage;

  // STT getters
  bool get isListening => _speechService.isListening;
  bool get isSTTAvailable => _speechService.isAvailable;
  String get recognizedText => _speechService.recognizedText;
  double get confidenceLevel => _speechService.confidenceLevel;
  List<LocaleName> get sttLocales => _speechService.locales;
  String get selectedSTTLocale => _speechService.selectedLocale;

  @override
  void onInit() {
    super.onInit();
    textController.addListener(_onTextChanged);
    
    // Listen to recognized text changes
    ever(_speechService.myRecognizedText, (String text) {
      if (text.isNotEmpty) {
        textController.text = text;
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  void _onTextChanged() {
    _isTextEmpty.value = textController.text.isEmpty;
  }

  void setTabIndex(int index) {
    _currentTabIndex.value = index;
  }

  // TTS methods
  Future<void> speakText() async {
    if (textController.text.isNotEmpty) {
      await _ttsService.speak(textController.text);
    }
  }

  Future<void> stopSpeaking() async {
    await _ttsService.stop();
  }

  Future<void> pauseSpeaking() async {
    await _ttsService.pause();
  }

  void setSpeechRate(double rate) {
    _ttsService.setSpeechRate(rate);
  }

  void setSpeechPitch(double pitch) {
    _ttsService.setSpeechPitch(pitch);
  }

  void setSpeechVolume(double volume) {
    _ttsService.setSpeechVolume(volume);
  }

  void setTTSLanguage(String language) {
    _ttsService.setLanguage(language);
  }

  // STT methods
  Future<void> startListening() async {
    await _speechService.startListening();
  }

  Future<void> stopListening() async {
    await _speechService.stopListening();
  }

  void clearText() {
    textController.clear();
    _speechService.clearText();
  }

  void setSTTLocale(String locale) {
    _speechService.setLocale(locale);
  }

  void copyTextToClipboard() {
    if (textController.text.isNotEmpty) {
      Get.snackbar(
        'Copied',
        'Text copied to clipboard',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
