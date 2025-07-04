import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'speech_module/screens/speech_home_screen.dart';
import 'speech_module/controllers/speech_controller.dart';
import 'speech_module/services/speech_service.dart';
import 'speech_module/services/tts_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize services and controllers
    Get.put(TTSService());
    Get.put(SpeechService());
    Get.put(SpeechController());

    return GetMaterialApp(
      title: 'Speech App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: SpeechHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
