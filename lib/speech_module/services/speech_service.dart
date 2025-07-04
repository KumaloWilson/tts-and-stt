import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class SpeechService extends GetxService {
  late SpeechToText _speechToText;
  
  final RxBool _isListening = false.obs;
  final RxBool _isAvailable = false.obs;
  final RxString myRecognizedText = ''.obs;
  final RxDouble _confidenceLevel = 0.0.obs;
  final RxList<LocaleName> _locales = <LocaleName>[].obs;
  final RxString _selectedLocale = 'en_US'.obs;

  bool get isListening => _isListening.value;
  bool get isAvailable => _isAvailable.value;
  String get recognizedText => myRecognizedText.value;
  double get confidenceLevel => _confidenceLevel.value;
  List<LocaleName> get locales => _locales;
  String get selectedLocale => _selectedLocale.value;

  @override
  void onInit() {
    super.onInit();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    _speechToText = SpeechToText();
    
    // Request microphone permission
    PermissionStatus permission = await Permission.microphone.request();
    
    if (permission.isGranted) {
      bool available = await _speechToText.initialize(
        onStatus: (status) {
          _isListening.value = status == 'listening';
        },
        onError: (error) {
          _isListening.value = false;
          Get.snackbar(
            'Speech Recognition Error',
            error.errorMsg,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        },
      );
      
      _isAvailable.value = available;
      
      if (available) {
        _locales.value = await _speechToText.locales();
      }
    } else {
      Get.snackbar(
        'Permission Denied',
        'Microphone permission is required for speech recognition',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> startListening() async {
    if (_isAvailable.value && !_isListening.value) {
      await _speechToText.listen(
        onResult: (result) {
          myRecognizedText.value = result.recognizedWords;
          _confidenceLevel.value = result.confidence;
        },
        localeId: _selectedLocale.value,
        listenMode: ListenMode.confirmation,
      );
    }
  }

  Future<void> stopListening() async {
    if (_isListening.value) {
      await _speechToText.stop();
      _isListening.value = false;
    }
  }

  void clearText() {
    myRecognizedText.value = '';
    _confidenceLevel.value = 0.0;
  }

  void setLocale(String locale) {
    _selectedLocale.value = locale;
  }
}
